//
//  ContentTableViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/4.
//

import UIKit
import Foundation
import SwiftHTTP

protocol DigestTableViewControllerDelegate {
    func collapseMenuViewController()
}

class DigestTableViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var digestNavigationItem: UINavigationItem!
    
    var delegate: DigestTableViewControllerDelegate?
    
    var allIn: [String : [DigestCell]] = [:]
    var curDigestCells : [DigestCell]?
    var curSource: String!
    var curURLString: String?
    let isReadedAccessoryViewSize: CGFloat = 10
    
    enum CellIdentifiers {
        static let digestTableViewCell = "DigestTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Navigation Settings
        
        curDigestCells = allIn[curSource]
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(self.refreshData as ()->Void), for: .valueChanged)
        
    }
    
    @objc func refreshData() {
        //移除老数据
        self.allIn[self.curSource] = self.allIn[self.curSource] ?? []

        if let rssLink = curURLString {
            self.allIn[curSource]!.removeAll()
            
            var req = URLRequest(urlString: rssLink)!
            req.timeoutInterval = 5
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: req){ (data, response, error) -> Void in
                if error != nil{
                    print(error!.localizedDescription)
                } else{
                    let parser = XMLParser(data: data!)
                    let rssXMLParser = RssXMLParser()
                    parser.delegate = rssXMLParser
                    parser.parse()
                    for rssitem in rssXMLParser.rssItems{
                        self.allIn[self.curSource]!.append(DigestCell(rssItem: rssitem))
                    }
                    DispatchQueue.main.async {
                        self.curDigestCells = self.allIn[self.curSource]
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
                    }
                }
            }
            dataTask.resume()
        } else{
            self.refreshControl!.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        menuBarButtonItem.tintColor = UIColor.white
        digestNavigationItem.title = curSource
        digestNavigationItem.titleView?.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let digestCells = curDigestCells else{
            return 0
        }
        print("reload")
        return digestCells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.digestTableViewCell, for: indexPath) as? DigestTableViewCell else {
            fatalError("The dequeued cell is not an instance of DigestTableViewCell")
        }
        guard let digestCell = curDigestCells?[indexPath.row] else {
            fatalError("digestCell = nil")
        }
        
        
        /*
        // 未读消息显示小红点
        if(!digestCell.isReaded){
            cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: isReadedAccessoryViewSize, height: isReadedAccessoryViewSize))
            cell.accessoryView?.layer.cornerRadius = isReadedAccessoryViewSize/2
            cell.accessoryView?.backgroundColor = UIColor(red: 0xff/255, green: 0x2d/255, blue: 0x51/255, alpha: 0.7)
        } else{
            cell.accessoryView = nil
        }
         */
        
        cell.titleLabel.text =  digestCell.rssItem._title
        cell.dateLabel.text = digestCell.rssItem._pubDate
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
 
    /*
    override public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        //设置cell的显示动画为3D缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
     */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
 
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "showContent":
            guard let contentViewController = segue.destination as? ContentViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedDigestTableViewCell = sender as? DigestTableViewCell else{
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedDigestTableViewCell) else{
                fatalError("The selected cell is not being display by the table")
            }
            contentViewController.digestCell = curDigestCells![indexPath.row]
            contentViewController.delegate = self
            self.navigationController?.navigationBar.isHidden = true
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
 

}

extension DigestTableViewController: MenuViewControllerDelegate{
    func didSelectMenuCell(_ menuCell: MenuCell){
        curSource = menuCell.title
        digestNavigationItem.title = curSource
        
        curURLString = menuCell.urlString
        if let rssLink = curURLString {
            self.allIn[self.curSource] = self.allIn[self.curSource] ?? []
            
            var req = URLRequest(urlString: rssLink)!
            req.timeoutInterval = 5
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: req){ (data, response, error) -> Void in
                if error != nil{
                    print(error!.localizedDescription)
                } else{
                    let parser = XMLParser(data: data!)
                    let rssXMLParser = RssXMLParser()
                    parser.delegate = rssXMLParser
                    parser.parse()
                    print(rssXMLParser.rssItems[0]._title)
                    for rssitem in rssXMLParser.rssItems{
                        self.allIn[self.curSource]!.append(DigestCell(rssItem: rssitem))
                    }
                    DispatchQueue.main.async {
                        self.curDigestCells = self.allIn[self.curSource]
                        self.tableView.reloadData()
                    }
                }
            }
            dataTask.resume()
        } else{
            curDigestCells = allIn[curSource]
            self.tableView.reloadData()
        }
        delegate?.collapseMenuViewController()
    }
}

extension DigestTableViewController: ContentViewControllerDelegate{
    func didBackFromContent(_ isChanged: Bool, digestCell: DigestCell){
        digestCell.isReaded = true
        if(isChanged){
            digestCell.isFavorite = !digestCell.isFavorite
            if(digestCell.isFavorite){
                allIn["Favorites"]?.append(digestCell)
            }
            else{
                if let indexOfDigestCell = allIn["Favorites"]?.index(of: digestCell){
                    allIn["Favorites"]?.remove(at: indexOfDigestCell)
                    curDigestCells = allIn[curSource]
                }
            }
        }
        self.tableView.reloadData()
    }
}
