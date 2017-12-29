//
//  SettingViewController.swift
//  AllIn
//
//  Created by Apple on 2017/12/25.
//

import UIKit

@objc protocol SettingViewControllerDelegate {
    func didSelectSourceCell(_ sourceCell: MenuCell)
}

class SettingViewController: UIViewController {
    
    //MARK: Properties
    var user: User?
    
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
    var txtLineB1: UILabel!
    
    @IBOutlet weak var sourceTableView: UITableView!
    var sourceCells: [MenuCell] = MenuCell.loadMenuCell()
    let sourceTableViewCell: String = "sourceTableViewCell"
    weak var delegate: SettingViewControllerDelegate?
    
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
    
    
    //MARK: Private Methods
    private func loadSource(){
        //sourceCells = self.user!.rssSources
        
        //sourceCells = MenuCell.loadMenuCell()
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
        txtSource.text = "Source"
        txtSource.font = UIFont.systemFont(ofSize: 14)
        txtSource.textColor = UIColor(displayP3Red:128/255, green:128/255, blue:128/255, alpha:1)
        txtSource.textAlignment = .left
        
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
        SettingsField.addSubview(txtLineB1)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "ReturnBlueImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        self.view.addSubview(btnCancel)
    }

}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sourceTableViewCell, for: indexPath) as? MenuTableViewCell else {
            fatalError("The dequeued cell is not an instance of MenuTableViewCell")
        }
        cell.configureForMenu(sourceCells[indexPath.row])
        return cell
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sourceCell = sourceCells[indexPath.row]
        delegate?.didSelectSourceCell(sourceCell)
    }
}
