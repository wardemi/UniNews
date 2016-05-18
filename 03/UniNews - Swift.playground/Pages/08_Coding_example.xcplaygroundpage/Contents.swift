/*:
 
 *A Swift programozási nyelv*
 
 ## Gyakorlat
 
 -----
 
 */


import UIKit


class ViewController: UIViewController
{
    var tableView: UITableView!
    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        
        
        self.items = [
            "Hello 1",
            "Hello 2",
            "Hello 3"
        ]

        self.tableView = UITableView(frame:self.view!.frame)
        self.tableView!.dataSource = self
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view?.addSubview(self.tableView)
        
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "\(self.items[indexPath.row])"
        
        return cell
    }
}



var ctrl = ViewController()
ctrl.view




/*:
 -----
 
 [Előző oldal](@previous) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */
