//
//  ContentTableViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/4.
//

import UIKit
import Foundation
import SwiftHTTP

@objc protocol DigestTableViewControllerDelegate {
    func collapseMenuViewController()
    func didClickAllInImageView()
}

class DigestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var txtTitle: UILabel!
    var txtCurDate: UILabel!
    var curDate: Date!
    var txtLastReflashDate: UILabel!
    var lastReflashDate: Date!
    var txtLine: UILabel!
    @IBOutlet weak var digestTableView: UITableView!
    
    weak var delegate: DigestTableViewControllerDelegate?
    
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
        digestTableView.dataSource = self
        digestTableView.delegate = self
        curDigestCells = allIn[curSource]
        digestTableView.refreshControl = UIRefreshControl()
        digestTableView.refreshControl!.addTarget(self, action: #selector(self.refreshData as ()->Void), for: .valueChanged)
        self.navigationController?.navigationBar.isHidden = true
        
        let mainSize = UIScreen.main.bounds.size
        let mainTitleField =  UIView(frame: CGRect(x: 0, y: 50, width: mainSize.width, height: 120))
        mainTitleField.layer.borderWidth = 0
        mainTitleField.layer.borderColor = UIColor.lightGray.cgColor
        mainTitleField.backgroundColor = UIColor.white
        self.view.addSubview(mainTitleField)
        
        txtTitle = UILabel(frame: CGRect(x: 30, y: 10, width: mainTitleField.frame.size.width-60, height: 44))
        txtTitle.text = curSource
        txtTitle.font = UIFont.systemFont(ofSize: 22)
        txtTitle.textColor = UIColor(displayP3Red:65/255, green:171/255, blue:225/255, alpha:1)
        txtTitle.textAlignment = .center
        
        txtCurDate = UILabel(frame: CGRect(x: 30, y: 40, width: mainTitleField.frame.size.width-60, height: 44))
        curDate = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        txtCurDate.text = dateformatter.string(from: curDate)
        txtCurDate.font = UIFont.systemFont(ofSize: 14)
        txtCurDate.textColor = UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1)
        txtCurDate.textAlignment = .center
        
        txtLastReflashDate = UILabel(frame: CGRect(x: 30, y: 70, width: mainTitleField.frame.size.width-60, height: 44))
        txtLastReflashDate.text = "Updated \(dateformatter.string(from: curDate)) Ago"
        txtLastReflashDate.font = UIFont.systemFont(ofSize: 10)
        txtLastReflashDate.textColor = UIColor(displayP3Red:96/255, green:96/255, blue:96/255, alpha:1)
        txtLastReflashDate.textAlignment = .center
        
        txtLine = UILabel(frame: CGRect(x: 10, y: 119, width: mainTitleField.frame.size.width-20, height: 1))
        txtLine.font = UIFont.systemFont(ofSize: 24)
        txtLine.backgroundColor = UIColor(displayP3Red:65/255, green:171/255, blue:225/255, alpha:1)
        txtLine.textAlignment = .center
        txtLine.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: mainTitleField.frame.size.width-20, height: 1))
        
        mainTitleField.addSubview(txtTitle)
        mainTitleField.addSubview(txtCurDate)
        mainTitleField.addSubview(txtLastReflashDate)
        mainTitleField.addSubview(txtLine)
    }
    
    @objc func refreshData() {
        self.allIn[self.curSource] = self.allIn[self.curSource] ?? []
        
        if let rssLink = curURLString {
            
            var req = URLRequest(urlString: rssLink)!
            req.timeoutInterval = 5
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: req){ (data, response, error) -> Void in
                if error != nil{
                    print(error!.localizedDescription)
                } else{
                    print("get data from Rss Source in refreshData")
                    let parser = XMLParser(data: data!)
                    let rssXMLParser = RssXMLParser()
                    parser.delegate = rssXMLParser
                    parser.parse()

                    for (index, rssItem) in rssXMLParser.rssItems.enumerated() {
                        if(DigestCell.checkItemExist(digestCells: self.allIn[self.curSource]!, rssItem: rssItem)){
                            print("Break at index: ", index)
                            break
                        }
                        self.allIn[self.curSource]!.insert(DigestCell(rssItem: rssItem), at: index)
                    }
                    
                    DispatchQueue.main.async {
                        self.curDigestCells = self.allIn[self.curSource]
                        self.digestTableView.reloadData()
                        self.digestTableView.refreshControl!.endRefreshing()
                    }
                }
            }
            dataTask.resume()
            
        } else{
            self.digestTableView.refreshControl!.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        //menuBarButtonItem.tintColor = UIColor.white
        //digestNavigationItem.title = curSource
        //digestNavigationItem.titleView?.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let digestCells = curDigestCells else{
            return 0
        }
        return digestCells.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        if(!digestCell.isReaded){
            cell.accessoryType = .disclosureIndicator
        } else{
            cell.accessoryType = .none
        }
        
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
            guard let indexPath = self.digestTableView.indexPath(for: selectedDigestTableViewCell) else{
                fatalError("The selected cell is not being display by the table")
            }
            contentViewController.curSource = curSource
            contentViewController.digestCell = curDigestCells![indexPath.row]
            contentViewController.delegate = self
            self.navigationController?.navigationBar.isHidden = true
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
 

}

extension DigestViewController: MenuViewControllerDelegate{
    func didSelectMenuCell(_ menuCell: MenuCell){
        curSource = menuCell.title
        txtTitle.text = curSource
        
        curURLString = menuCell.urlString
        if let rssLink = curURLString {
            print(rssLink)
            self.allIn[self.curSource] = self.allIn[self.curSource] ?? []
            
            var req = URLRequest(urlString: rssLink)!
            req.timeoutInterval = 5
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: req){ (data, response, error) -> Void in
                if error != nil{
                    print(error!.localizedDescription)
                } else{
                    print("get data from Rss Source in didSelectMenuCell")
                    let parser = XMLParser(data: data!)
                    let rssXMLParser = RssXMLParser()
                    parser.delegate = rssXMLParser
                    parser.parse()
                    
                    for (index, rssItem) in rssXMLParser.rssItems.enumerated() {
                        if(DigestCell.checkItemExist(digestCells: self.allIn[self.curSource]!, rssItem: rssItem)) {
                            print("Break at index: ", index)
                            break
                        }
                        self.allIn[self.curSource]!.insert(DigestCell(rssItem: rssItem), at: index)
                    }
                    DispatchQueue.main.async {
                        self.curDigestCells = self.allIn[self.curSource]
                        self.digestTableView.reloadData()
                    }
                }
            }
            
            dataTask.resume()
        } else{
            curDigestCells = allIn[curSource]
            self.digestTableView.reloadData()
        }
        delegate?.collapseMenuViewController()
    }
}

extension DigestViewController: ContentViewControllerDelegate{
    func didBackFromContent(_ isChanged: Bool, digestCell: DigestCell){
        digestCell.isReaded = true
        if(isChanged){
            digestCell.isFavorite = !digestCell.isFavorite
            if(digestCell.isFavorite){
                allIn["Favorites"] = allIn["Favorites"] ?? []
                allIn["Favorites"]!.append(digestCell)
            }
            else{
                if let indexOfDigestCell = allIn["Favorites"]?.index(of: digestCell){
                    allIn["Favorites"]?.remove(at: indexOfDigestCell)
                    curDigestCells = allIn[curSource]
                }
            }
        }
        self.digestTableView.reloadData()
    }
    
    func didClickAllInImageView(){
        self.delegate?.didClickAllInImageView()
    }
}
