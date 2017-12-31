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
    func didClickBackgroundImgView()
}

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var allInLabel: UILabel!
    @IBOutlet weak var allInImageView: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    
    weak var delegate: MenuViewControllerDelegate?
    var userAccount: String?
    var menuCells: [MenuCell]!
    
    enum CellIdentifiers {
        static let menuCell = "MenuTableViewCell"
    }
    
    @IBAction func unwindFromSettingView(_ sender: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //menuTableView.reloadData()
        let alInImageClick = UITapGestureRecognizer(target: self, action: #selector(allInImageViewClick))
        allInImageView.addGestureRecognizer(alInImageClick)
        allInImageView.isUserInteractionEnabled = true
        
        let alInLabelClick = UITapGestureRecognizer(target: self, action: #selector(allInImageViewClick))
        allInLabel!.text = userAccount ?? "AllIner"
        allInLabel.addGestureRecognizer(alInLabelClick)
        allInLabel.isUserInteractionEnabled = true
        
        let settingImageClick = UITapGestureRecognizer(target: self, action: #selector(settingImageViewClick))
        settingImageView.addGestureRecognizer(settingImageClick)
        settingImageView.isUserInteractionEnabled = true
        
        let settingLabelClick = UITapGestureRecognizer(target: self, action: #selector(settingImageViewClick))
        settingsLabel.addGestureRecognizer(settingLabelClick)
        settingsLabel.isUserInteractionEnabled = true
        
        let backgroundImgClick = UITapGestureRecognizer(target: self, action: #selector(selectBackgroundImg))
        backgroundImg.addGestureRecognizer(backgroundImgClick)
        backgroundImg.isUserInteractionEnabled = true
        
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
    
    @objc func selectBackgroundImg() -> Void {
        self.delegate?.didClickBackgroundImgView()
    }
    
    @objc func setBackgroundImg(img: UIImage?) -> Void {
        if let tmp = img {
            backgroundImg.image = tmp
        }
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
