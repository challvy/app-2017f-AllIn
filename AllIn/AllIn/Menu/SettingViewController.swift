//
//  SettingViewController.swift
//  AllIn
//
//  Created by Apple on 2017/12/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    //MARK: Properties
    var user: User?
    var sourceName:String?
    var sourceURL:String?
    
    var btnCancel: UIButton!
    var txtSettings: UILabel!
    var txtLineMain: UILabel!
    
    var txtPersonal: UILabel!
    var txtLineA1: UILabel!
    var btnAccount: UIButton!
    var txtLineA2: UILabel!
    var btnDisplay: UIButton!
    var txtLineA3: UILabel!
    var txtSource: UILabel!
    var btnEdit: UIButton!
    var txtLineB1: UILabel!
    
    @IBOutlet weak var sourceTableView: UITableView!
    var sourceCells: [MenuCell] = MenuCell.loadMenuCell()
    let sourceTableViewCell: String = "sourceTableViewCell"
    
    @IBAction func unwindFromSettingView(_ sender: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initUI()
        loadSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Button Action
    @objc func btnAccountTapped(_ sender: UIButton) {
        let setting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingAccountView") as! SettingAccountViewController
        self.present(setting, animated: true, completion: nil)
    }
    
    @objc func btnDisplayTapped(_ sender: UIButton) {
        let setting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingDisplayView") as! SettingDisplayViewController
        self.present(setting, animated: true, completion: nil)
    }
    
    @objc func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func btnEditTapped(_ sender: UIButton) {
        if btnEdit.title(for: .normal) == "Edit" && sourceTableView.numberOfRows(inSection: 0)>1{
            sourceTableView.setEditing(true, animated: true)
            btnEdit.setTitle("Done", for: .normal)
        } else {
            sourceTableView.setEditing(false, animated: true)
            btnEdit.setTitle("Edit", for: .normal)
        }
    }
    
    func checkURL(_ url: String) -> Bool {
        guard url.count > 8 else {
            return false
        }
        
        let httpUrl = url.index(url.startIndex, offsetBy: 7)
        let subHttpUrl = String(url[..<httpUrl])
        if subHttpUrl.lowercased().contains("http://") == true {
            return true
        }
        
        let httpsUrl = url.index(url.startIndex, offsetBy: 8)
        let subHttpsUrl = String(url[..<httpsUrl])
        if subHttpsUrl.lowercased().contains("https://") == true {
            return true
        }
        return false
    }
    
    func errorURLAlert() {
        var alertController: UIAlertController?
        
        // AlertController
        alertController = UIAlertController(title:"Error", message:"The URL doesn't confirm to any protocol.",preferredStyle:.alert)
        
        let actionOK = UIAlertAction(title:"OK",style:UIAlertActionStyle.cancel,handler:{(paramAction:UIAlertAction!) in
            
            print("The OK button was trapped")
        })

        alertController!.addAction(actionOK)
        self.present(alertController!,animated:true,completion:nil)
    }
    
    func addedSucccessfullyAlert() {
        var alertController: UIAlertController?
        
        // AlertController
        alertController = UIAlertController(title:"Success", message:"The source has been added.",preferredStyle:.alert)
        
        let actionOK = UIAlertAction(title:"OK",style:UIAlertActionStyle.cancel,handler:{(paramAction:UIAlertAction!) in
            
            print("The OK button was trapped")
        })

        alertController!.addAction(actionOK)
        self.present(alertController!,animated:true,completion:nil)
    }
    
    func changedSucccessfullyAlert() {
        var alertController: UIAlertController?
        
        // AlertController
        alertController = UIAlertController(title:"Success", message:"The source has been changed.",preferredStyle:.alert)
        
        let actionOK = UIAlertAction(title:"OK",style:UIAlertActionStyle.cancel,handler:{(paramAction:UIAlertAction!) in
            
            print("The OK button was trapped")
        })
        
        alertController!.addAction(actionOK)
        self.present(alertController!,animated:true,completion:nil)
    }
    
    func didSelectSourceCell(_ sourceCell: MenuCell){
        if sourceCell.title == "Add" {
            var alertController: UIAlertController?
            
            // AlertController
            alertController = UIAlertController(title:"Add More Sources", message:"Input title and URL.",preferredStyle:.alert)
            
            alertController!.addTextField(configurationHandler: {(textField:UITextField!) in
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                
                textField.placeholder = "Title"
            })
            
            alertController!.addTextField(configurationHandler: {(textField:UITextField!) in
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                
                textField.placeholder = "URL"
            })
            
            let actionCancel = UIAlertAction(title:"Cancel",style:UIAlertActionStyle.cancel,handler:{(paramAction:UIAlertAction!) in
                
                print("The Cancel button was trapped")
            })
            
            let actionDone = UIAlertAction(title: "Done", style: UIAlertActionStyle.destructive, handler: {[weak self] (paramAction:UIAlertAction!) in
                
                NotificationCenter.default.removeObserver(self!, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
 
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    self?.sourceName = theTextFields[0].text
                    self?.sourceURL = theTextFields[1].text
                }
                
                if self?.checkURL((self?.sourceURL)!) == false {
                    self?.errorURLAlert()
                } else {
                    // Flag of Adding sources
                    self?.addedSucccessfullyAlert()
                }
            })
            
            alertController!.addAction(actionCancel)
            alertController!.addAction(actionDone)
            actionDone.isEnabled = false
            
            self.present(alertController!,animated:true,completion:nil)

        } else {
            var alertController: UIAlertController?
            
            // AlertController
            alertController = UIAlertController(title:"Change the Source", message:"Input the new title and URL to change.",preferredStyle:.alert)
            
            alertController!.addTextField(configurationHandler: {(textField:UITextField!) in
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                
                textField.placeholder = sourceCell.title
            })
            
            alertController!.addTextField(configurationHandler: {(textField:UITextField!) in
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                
                textField.placeholder = sourceCell.urlString
            })
            
            let actionCancel = UIAlertAction(title:"Cancel",style:UIAlertActionStyle.cancel,handler:{(paramAction:UIAlertAction!) in
                
                print("The Cancel button was trapped")
            })
            
            let actionDone = UIAlertAction(title: "Done", style: UIAlertActionStyle.destructive, handler: {[weak self] (paramAction:UIAlertAction!) in
                
                NotificationCenter.default.removeObserver(self!, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
                
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    self?.sourceName = theTextFields[0].text
                    self?.sourceURL = theTextFields[1].text
                }
                
                if self?.checkURL((self?.sourceURL)!) == false {
                    self?.errorURLAlert()
                } else {
                    // Flag of Adding sources
                    self?.changedSucccessfullyAlert()
                }
            })
            
            alertController!.addAction(actionCancel)
            alertController!.addAction(actionDone)
            actionDone.isEnabled = false
            
            self.present(alertController!,animated:true,completion:nil)
        }
    }
    
    @objc func alertTextFieldDidChange(_ notification: NSNotification){
        let alertController = self.presentedViewController as! UIAlertController?
        let actionDone = alertController?.actions.last as UIAlertAction!
        if alertController != nil {
            let inputFirst = alertController?.textFields?.first as UITextField!
            let inputLast = alertController?.textFields?.last as UITextField!
            if (inputFirst?.text?.isEmpty)! == false && (inputLast?.text?.isEmpty)! == false {
                actionDone?.isEnabled = true
            } else {
                actionDone?.isEnabled = false
            }
        }
    }
    
    
    //MARK: Private Methods
    private func loadSource(){
        //sourceCells = self.user!.rssSources
        sourceCells = MenuCell.loadMenuCell()
        let cell = MenuCell(title: "Add", image: #imageLiteral(resourceName: "AddImage"), urlString: nil)
        sourceCells.append(cell)
    }
    
    private func initUI() {
        let mainSize = UIScreen.main.bounds.size
        
        // Title
        txtSettings = UILabel(frame: CGRect(x: 60, y: 23, width: mainSize.width-60, height: 44))
        txtSettings.textAlignment = .left
        txtSettings.text = "Settings"
        txtSettings.font = UIFont.systemFont(ofSize: 18)
        txtSettings.textColor = UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1)
        
        txtLineMain = UILabel(frame: CGRect(x: 15, y: 79, width: mainSize.width-30, height: 1))
        txtLineMain.backgroundColor = UIColor(displayP3Red:65/255, green:171/255, blue:225/255, alpha:1)
        txtLineMain.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: mainSize.width-20, height: 1))
        self.view.addSubview(txtSettings)
        self.view.addSubview(txtLineMain)
        
        // Content
        let SettingsField =  UIView(frame: CGRect(x: 0, y: 80, width: mainSize.width, height: 180))
        SettingsField.layer.borderWidth = 0
        SettingsField.layer.borderColor = UIColor.lightGray.cgColor
        SettingsField.backgroundColor = UIColor.white
        self.view.addSubview(SettingsField)
        
        // >Personal Settings
        txtPersonal = UILabel(frame: CGRect(x: 15, y: 25, width: SettingsField.frame.size.width-60, height: 20))
        txtPersonal.text = "Personal"
        txtPersonal.font = UIFont.systemFont(ofSize: 14)
        txtPersonal.textColor = UIColor(displayP3Red:128/255, green:128/255, blue:128/255, alpha:1)
        txtPersonal.textAlignment = .left
        
        txtLineA1 = UILabel(frame: CGRect(x: 0, y: 49, width: SettingsField.frame.size.width, height: 1))
        txtLineA1.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA1.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnAccount = UIButton(frame: CGRect(x: 20, y: 55, width: SettingsField.frame.size.width, height: 30))
        btnAccount.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnAccount.setTitle("Account", for: .normal)
        btnAccount.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnAccount.contentHorizontalAlignment = .left
        btnAccount.addTarget(self, action: #selector(btnAccountTapped(_:)), for: .touchUpInside)
        
        txtLineA2 = UILabel(frame: CGRect(x: 15, y: 89, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA2.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA2.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnDisplay = UIButton(frame: CGRect(x: 20, y: 95, width: SettingsField.frame.size.width, height: 30))
        btnDisplay.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnDisplay.setTitle("Display", for: .normal)
        btnDisplay.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnDisplay.contentHorizontalAlignment = .left
        btnDisplay.addTarget(self, action: #selector(btnDisplayTapped(_:)), for: .touchUpInside)
        
        txtLineA3 = UILabel(frame: CGRect(x: 0, y: 129, width: SettingsField.frame.size.width, height: 1))
        txtLineA3.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA3.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        // >Source Management
        txtSource = UILabel(frame: CGRect(x: 15, y: 155, width: SettingsField.frame.size.width-60, height: 20))
        txtSource.text = "Sources"
        txtSource.font = UIFont.systemFont(ofSize: 14)
        txtSource.textColor = UIColor(displayP3Red:128/255, green:128/255, blue:128/255, alpha:1)
        txtSource.textAlignment = .left
        
        btnEdit = UIButton(frame: CGRect(x: 330, y: 155, width: 60, height: 20))
        btnEdit.setTitleColor(UIColor(displayP3Red:65/255, green:171/255, blue:235/255, alpha:1), for: .normal)
        btnEdit.setTitle("Edit", for: .normal)
        btnEdit.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnEdit.contentHorizontalAlignment = .right
        btnEdit.addTarget(self, action: #selector(btnEditTapped(_:)), for: .touchUpInside)
        
        txtLineB1 = UILabel(frame: CGRect(x: 0, y: 179, width: SettingsField.frame.size.width, height: 1))
        txtLineB1.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineB1.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        SettingsField.addSubview(txtPersonal)
        SettingsField.addSubview(txtLineA1)
        SettingsField.addSubview(btnAccount)
        SettingsField.addSubview(txtLineA2)
        SettingsField.addSubview(btnDisplay)
        SettingsField.addSubview(txtLineA3)
        
        SettingsField.addSubview(txtSource)
        SettingsField.addSubview(btnEdit)
        SettingsField.addSubview(txtLineB1)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "ReturnBlueImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        self.view.addSubview(btnCancel)
        self.view.addSubview(sourceTableView)
    }

}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sourceTableViewCell, for: indexPath) as? SourceTableViewCell else {
            fatalError("The dequeued cell is not an instance of SourceTableViewCell")
        }
        cell.configureForMenu(sourceCells[indexPath.row])
        return cell
    }
    
    // Move
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if indexPath.row == sourceCells.count-1 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath != destinationIndexPath{
            let itemValue: MenuCell = sourceCells[sourceIndexPath.row]
            
            sourceCells.remove(at: sourceIndexPath.row)
        
            if destinationIndexPath.row > sourceCells.count {
                sourceCells.append(itemValue)
            } else {
                sourceCells.insert(itemValue, at: destinationIndexPath.row)
            }
            if destinationIndexPath.row == sourceCells.count-1 {
                tableView.reloadData()
                let itemValue2: MenuCell = sourceCells[destinationIndexPath.row]
                sourceCells[destinationIndexPath.row] = sourceCells[destinationIndexPath.row-1]
                sourceCells[destinationIndexPath.row-1] = itemValue2
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == sourceCells.count-1 {
            return .none
        }
        return .delete
    }
    
    // Add to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == sourceCells.count-1 {
            return false
        }
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sourceCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sourceCell = sourceCells[indexPath.row]
        didSelectSourceCell(sourceCell)
    }
}
