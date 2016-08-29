//
//  MediaViewController.swift
//  UniNews
//
//  Created by Canecom on 29/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class MediaViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var layer: AVPlayerLayer?
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playVideo()
//        self.playAudio()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.playVideoInPlayer()
    }
}


extension MediaViewController {
    
    @IBAction func openCameraButtonTouched(sender: AnyObject) {
        self.showImagePicker(.Camera)
    }
    
    @IBAction func openPhotoLibraryButtonTouched(sender: AnyObject) {
        self.showImagePicker(.PhotoLibrary)
    }

    @IBAction func saveButtonTouched(sender: AnyObject) {
        let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
    }
}


extension MediaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func showImagePicker(source: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else { return }
        let imagePicker           = UIImagePickerController()
        imagePicker.delegate      = self
        imagePicker.sourceType    = source;
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}


extension MediaViewController {

    func playVideoInPlayer() {
        let url = NSURL(string: "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4")!
//        let url = NSURL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")!
        
        let asset = AVURLAsset(URL: url)
        let item = AVPlayerItem(asset: asset)
        
        let player = AVPlayer(playerItem: item)
        
        let vc = AVPlayerViewController()
        vc.player = player;
        vc.view.frame = self.view.bounds
        vc.showsPlaybackControls = true
        
        self.presentViewController(vc, animated: true) {
            player.play()
        }
//        self.view.addSubview(vc.view)
//        player.play()
    }
}


extension MediaViewController {

    func playAudio() {
        let path = NSBundle.mainBundle().pathForResource("sound", ofType: "mp3")!
        let url = NSURL(string: path)!
        
        let player = try? AVAudioPlayer(contentsOfURL: url)
        player?.numberOfLoops = -1
        player?.play()
        
        self.audioPlayer = player
        
    }
}


extension MediaViewController {

    func playVideo() {
        if let url = NSBundle.mainBundle().URLForResource("video", withExtension: "mp4") where self.layer == nil {
            let player                  = AVPlayer(URL: url)
            player.muted                = true
            player.actionAtItemEnd      = .None
            self.layer                  = AVPlayerLayer()
            self.layer?.player          = player
            self.layer?.frame           = self.view.bounds
            self.layer?.backgroundColor = UIColor.blackColor().CGColor
            self.layer?.videoGravity    = AVLayerVideoGravityResizeAspectFill
            self.layer?.opacity         = 0.0
            
            self.view.layer.insertSublayer(layer!, below: self.view.layer)
            
            player.play()
            
            
            let animation = CABasicAnimation(keyPath: "opacity")
            
            animation.fromValue = 0.0
            animation.toValue   = 0.5
            animation.duration  = 1.0
            
            self.layer?.addAnimation(animation, forKey: "opacity")
            
            self.layer?.opacity = 1
            
            NSNotificationCenter.defaultCenter().addObserver(self,
                                                             selector: #selector(self.replay),
                                                             name: AVPlayerItemDidPlayToEndTimeNotification,
                                                             object: nil)
            
            player.currentItem?.addObserver(self, forKeyPath: "status", options: [], context: nil)
            player.addObserver(self, forKeyPath: "rate", options: [], context: nil)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath! == "status" {
            if self.layer!.player!.status == .Failed {
                print("error")
            }
        }
        else if keyPath! == "rate" {
            if self.layer!.player!.rate == 0 &&
                CMTimeCompare(self.layer!.player!.currentTime(), kCMTimeZero) == 1 &&
                CMTimeCompare(self.layer!.player!.currentTime(), self.layer!.player!.currentItem!.duration) == -1
            {
                self.handleStalled()
            }
        }
    }

    func handleStalled() {
        if self.layer!.player!.currentItem!.playbackLikelyToKeepUp ||
            self.availableDuration() - CMTimeGetSeconds(self.layer!.player!.currentItem!.currentTime()) > 10
        {
            self.layer?.player?.play()
        }
        else {
            self.performSelector(#selector(self.handleStalled), withObject: nil, afterDelay: 0.5)
        }
    }
    
    func availableDuration() -> NSTimeInterval {
        let ranges = self.layer?.player?.currentItem?.loadedTimeRanges
        let timeRange = ranges?.first?.CMTimeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange!.start)
        let durationSeconds = CMTimeGetSeconds(timeRange!.duration)
        let result = startSeconds + durationSeconds
        return NSTimeInterval(result)
    }
    
    func replay() {
        self.layer?.player?.pause()
        self.layer?.player?.currentItem?.seekToTime(kCMTimeZero)
        self.layer?.player?.play()
    }
}


