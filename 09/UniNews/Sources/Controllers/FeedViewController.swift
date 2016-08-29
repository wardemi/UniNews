//
//  ViewController.swift
//  UniNews
//
//  Created by Canecom on 10/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit
import CloudKit


class FeedViewController: BaseViewController {
  
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataSource: [NewsRecord] = []
    
    var dateFormatter: NSDateFormatter = {
        let formatter       = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .ShortStyle
        return formatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News feed"

        self.register(nibNamed: "FeedCell")
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
        
        
        self.reloadNavbarItems()

        let image = UIImage(named: "Link")?.scaled(to: CGSize(width: 24, height: 24))
        let leftItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(self.userActions))
        leftItem.tintColor = Uni.colors.green
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.reload()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.reloadWith(_:)),
                                                         name: "FeedItemCreatedNotification",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.reload),
                                                         name: "ReloadFeedNotification",
                                                         object: nil)
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.reloadNavbarItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    func reloadNavbarItems() {
        if Session.shared.isLoggedIn {
            let image = UIImage(named: "Plus")?.scaled(to: CGSize(width: 24, height: 24))
            let leftItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(self.createItem))
            leftItem.tintColor = Uni.colors.blue
            self.navigationItem.rightBarButtonItem = leftItem
        }
    }
}


extension FeedViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FeedCell", forIndexPath: indexPath)
        let item = self.dataSource[indexPath.row]

        if let cell = cell as? FeedCell {
            cell.profileName.text       = item.authorObject?.name ?? "N/A"
            cell.profileImageView.image = item.authorObject?.avatar?.localImageValue ?? UIImage(named: "DefaultUser")
            
            cell.imageView.hidden = true
            if let image = item.image?.localImageValue {
                cell.imageView.image = image
                cell.imageView.hidden = false
            }

            cell.detailTextLabel.text   = item.content
            cell.textLabel.text         = "N/A"

            if let date = item.record.creationDate {
                cell.textLabel.text = self.dateFormatter.stringFromDate(date)
            }
            if let urlString = item.url where urlString.isValidUrl {
                cell.button.hidden = false
            }
        }
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let item = self.dataSource[indexPath.row]

        if let urlString = item.url, let url = NSURL(string: urlString) where urlString.isValidUrl {
            
            UIApplication.sharedApplication().openURL(url)
        }
    }
}



extension FeedViewController: UICollectionViewDelegateFlowLayout
{
    private var padding: CGFloat { return 16 }
    private var doublePadding: CGFloat { return self.padding * 2.0 }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let item = self.dataSource[indexPath.row]
        
        var extraHeight: CGFloat = 88
        if item.image?.localImageValue != nil {
            extraHeight = 388
        }

        let maxWidth   = collectionView.bounds.width - self.doublePadding
        let textHeight = item.content.labelHeight(forWidth: maxWidth, font: Uni.fonts.small)
        return CGSize(width: maxWidth, height: textHeight + extraHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: self.doublePadding, left: self.padding, bottom: self.doublePadding, right: self.padding)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return self.padding
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0
    }
}








extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    func reloadWith(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo as? [String:AnyObject],
            let news = userInfo["item"] as? NewsRecord
        else {
            return
        }
       
        CKRecord(recordType: "Account", recordID: news.author.recordID).fetchLatest { result in
            switch result {
            case .success(let item):
                news.authorObject = AccountRecord(record: item)
                
                self.dataSource.append(news)
                self.dataSource = self.dataSource.sort { $0.record.creationDate!.compare($1.record.creationDate!) == .OrderedDescending }
                
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.collectionView.reloadData()
                }
                
            case .error(let error):
                dlog(error)
            }
        }

        
        //        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        //        dispatch_after(delayTime, dispatch_get_main_queue()) {
        //            self.reload()
        //        }
    }
    
    
    func reload() {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.dataSource = []
            self.collectionView.reloadData()
            self.activityIndicator.startAnimating()
        }

        NewsRecord.fetchAll { result in
            switch result {
            case .success(let items):
                self.dataSource = items
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            case .error(let error):
                dlog(error)
            }
        }
    }

    func createItem() {
        guard let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddTextViewController") else {
            return
        }
        self.showViewController(UINavigationController(rootViewController: viewController), sender: nil)
    }
    
    func userActions() {
        let optionMenu = UIAlertController(title: nil, message: "Account", preferredStyle: .ActionSheet)
        
        let loginAction = UIAlertAction(title: "Login", style: .Default) { _ in
            guard let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") else {
                return
            }
            self.presentViewController(viewController, animated: true, completion: nil)
        }
        
        let registerAction = UIAlertAction(title: "Register", style: .Default) { _ in
            guard let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") else {
                return
            }
            self.presentViewController(viewController, animated: true, completion: nil)
        }
        
        let profileAction = UIAlertAction(title: "Profile", style: .Default) { _ in
            guard let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") else {
                return
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            self.presentViewController(navigationController, animated: true, completion: nil)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            
        }

        if !Session.shared.isLoggedIn {
            optionMenu.addAction(loginAction)
            optionMenu.addAction(registerAction)
        }
        else {
            optionMenu.addAction(profileAction)
        }

        optionMenu.addAction(cancelAction)
        
        optionMenu.popoverPresentationController?.barButtonItem = self.navigationItem.leftBarButtonItem
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
}

