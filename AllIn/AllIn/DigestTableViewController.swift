//
//  ContentTableViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/4.
//

import UIKit

class DigestTableViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var digestNavigationItem: UINavigationItem!
    
    var delegate: DigestTableViewControllerDelegate?
    
    var allIn: [String : [DigestCell]]!
    var curDigestCells : [DigestCell]?
    var curSource: String!
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
        return digestCells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.digestTableViewCell, for: indexPath) as? DigestTableViewCell else {
            fatalError("The dequeued cell is not an instance of DigestTableViewCell")
        }
        guard let digestCell = curDigestCells?[indexPath.row] else {
            fatalError("digestCell = nil")
        }
        
        if(!digestCell.isReaded){
            cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: isReadedAccessoryViewSize, height: isReadedAccessoryViewSize))
            cell.accessoryView?.layer.cornerRadius = isReadedAccessoryViewSize/2
            cell.accessoryView?.backgroundColor = UIColor(red: 0xff/255, green: 0x2d/255, blue: 0x51/255, alpha: 0.7)
        } else{
            cell.accessoryView = nil
        }
        
        cell.titleLabel.text =  digestCell.title
        cell.abstractLabel.text = digestCell.abstract ?? ""
        
        return cell
    }
 

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
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
 

}

extension DigestTableViewController: MenuViewControllerDelegate{
    func didSelectMenuCell(_ menuCell: MenuCell){
        curSource = menuCell.title
        curDigestCells = allIn[curSource]
        digestNavigationItem.title = curSource
        self.tableView.reloadData()
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
