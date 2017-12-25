//
//  MenuViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/3.
//

import UIKit
import Foundation

@objc protocol MenuViewControllerDelegate {
    func didSelectMenuCell(_ menuCell: MenuCell)
    func didClickAllInImageView()
    func didClickSettingImageView()
}

@IBDesignable
class MenuViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var allInLabel: UILabel!
    @IBOutlet weak var allInImageView: UIImageView!
    @IBInspectable @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var settingImageView: UIImageView!
    
    weak var delegate: MenuViewControllerDelegate?
    var userAccount: String?
    var menuCells: [MenuCell]!
    
    enum CellIdentifiers {
        static let menuCell = "MenuTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //menuTableView.reloadData()
        let alInImageClick = UITapGestureRecognizer(target: self, action: #selector(allInImageViewClick))
        allInImageView.addGestureRecognizer(alInImageClick)
        allInImageView.isUserInteractionEnabled = true
        allInLabel!.text = userAccount ?? "AllIner"
        
        let settingImageClick = UITapGestureRecognizer(target: self, action: #selector(settingImageViewClick))
        settingImageView.addGestureRecognizer(settingImageClick)
        settingImageView.isUserInteractionEnabled = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func allInImageViewClick() -> Void {
        self.delegate?.didClickAllInImageView()
    }
    
    @objc func settingImageViewClick() -> Void {
        self.delegate?.didClickSettingImageView()
    }
    
}

//MARK: Table View Data Source
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.menuCell, for: indexPath) as? MenuTableViewCell else {
            fatalError("The dequeued cell is not an instance of MenuTableViewCell")
        }
        cell.configureForMenu(menuCells[indexPath.row])
        return cell
    }
}

//MARK: Table View Delegate
extension MenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuCell = menuCells[indexPath.row]
        delegate?.didSelectMenuCell(menuCell)
    }
}
