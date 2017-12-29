//
//  SettingDisplayViewController.swift
//  AllIn
//
//  Created by Apple on 2017/12/29.
//

import UIKit

class SettingDisplayViewController: UIViewController {
    
    //MARK: Properties
    var user: User?
    
    var btnCancel: UIButton!
    
    var txtSettingsDisplay: UILabel!
    var txtLineMain: UILabel!
    
    var txtText: UILabel!
    var txtLineA1: UILabel!
    var btnSize: UIButton!
    var pickerSize: UIPickerView!
    var txtLineA2: UILabel!
    var btnFont: UIButton!
    var txtLineA3: UILabel!
    var btnBold: UIButton!
    var isBold: Bool!
    var txtLineA4: UILabel!
    var boldSwitch: UISwitch!
    var txtSource: UILabel!
    var txtLineB1: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        
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
    
    // Button Action
    @objc func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseBold(_ sender: UISwitch) {
        if(isBold == true){
            isBold = false;
        } else {
            isBold = true;
        }
    }
    
    
    // Private func
    private func initUI(){
        let mainSize = UIScreen.main.bounds.size
        
        // Title
        txtSettingsDisplay = UILabel(frame: CGRect(x: 60, y: 23, width: mainSize.width-60, height: 44))
        txtSettingsDisplay.text = "Display"
        txtSettingsDisplay.font = UIFont.systemFont(ofSize: 18)
        txtSettingsDisplay.textColor = UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1)
        txtSettingsDisplay.textAlignment = .left
        
        txtLineMain = UILabel(frame: CGRect(x: 15, y: 79, width: mainSize.width-30, height: 1))
        txtLineMain.backgroundColor = UIColor(displayP3Red:65/255, green:171/255, blue:225/255, alpha:1)
        txtLineMain.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: mainSize.width-20, height: 1))
        self.view.addSubview(txtSettingsDisplay)
        self.view.addSubview(txtLineMain)
        
        // Content
        let SettingsField =  UIView(frame: CGRect(x: 0, y: 80, width: mainSize.width, height: 200))
        SettingsField.layer.borderWidth = 0
        SettingsField.layer.borderColor = UIColor.lightGray.cgColor
        SettingsField.backgroundColor = UIColor.white
        self.view.addSubview(SettingsField)
        
        // >Text Settings
        txtText = UILabel(frame: CGRect(x: 15, y: 25, width: SettingsField.frame.size.width-60, height: 20))
        txtText.text = "Text"
        txtText.font = UIFont.systemFont(ofSize: 14)
        txtText.textColor = UIColor(displayP3Red:128/255, green:128/255, blue:128/255, alpha:1)
        txtText.textAlignment = .left
        
        txtLineA1 = UILabel(frame: CGRect(x: 0, y: 49, width: SettingsField.frame.size.width, height: 1))
        txtLineA1.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA1.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnSize = UIButton(frame: CGRect(x: 20, y: 55, width: SettingsField.frame.size.width, height: 30))
        btnSize.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnSize.setTitle("Size", for: .normal)
        btnSize.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnSize.contentHorizontalAlignment = .left
        //btnSize.addTarget(self, action: #selector(btnAccountTapped(_:)), for: .touchUpInside)
        
        pickerSize = UIPickerView()
        
        txtLineA2 = UILabel(frame: CGRect(x: 15, y: 89, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA2.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA2.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnFont = UIButton(frame: CGRect(x: 20, y: 95, width: SettingsField.frame.size.width, height: 30))
        btnFont.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnFont.setTitle("Font", for: .normal)
        btnFont.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnFont.contentHorizontalAlignment = .left
        //btnFont.addTarget(self, action: #selector(btnDisplayTapped(_:)), for: .touchUpInside)
        
        txtLineA3 = UILabel(frame: CGRect(x: 15, y: 129, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA3.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA3.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnBold = UIButton(frame: CGRect(x: 20, y: 135, width: SettingsField.frame.size.width, height: 30))
        btnBold.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnBold.setTitle("Bold", for: .normal)
        btnBold.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnBold.contentHorizontalAlignment = .left
        //btnBold.addTarget(self, action: #selector(btnDisplayTapped(_:)), for: .touchUpInside)
        
        boldSwitch = UISwitch(frame: CGRect(x: 340, y: 135, width: SettingsField.frame.size.width, height: 30))
        boldSwitch.isOn = false
        boldSwitch.addTarget(self, action: #selector(chooseBold(_:)), for: .valueChanged)
        
        txtLineA4 = UILabel(frame: CGRect(x: 0, y: 169, width: SettingsField.frame.size.width, height: 1))
        txtLineA4.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA4.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        // >
        txtSource = UILabel(frame: CGRect(x: 15, y: 195, width: SettingsField.frame.size.width-60, height: 20))
        txtSource.text = "Other"
        txtSource.font = UIFont.systemFont(ofSize: 14)
        txtSource.textColor = UIColor(displayP3Red:128/255, green:128/255, blue:128/255, alpha:1)
        txtSource.textAlignment = .left
        
        txtLineB1 = UILabel(frame: CGRect(x: 0, y: 219, width: SettingsField.frame.size.width, height: 1))
        txtLineB1.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineB1.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        SettingsField.addSubview(txtText)
        SettingsField.addSubview(txtLineA1)
        SettingsField.addSubview(btnSize)
        SettingsField.addSubview(txtLineA2)
        SettingsField.addSubview(btnFont)
        SettingsField.addSubview(txtLineA3)
        SettingsField.addSubview(btnBold)
        SettingsField.addSubview(boldSwitch)
        SettingsField.addSubview(txtLineA4)
        
        SettingsField.addSubview(txtSource)
        SettingsField.addSubview(txtLineB1)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "ReturnBlueImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        self.view.addSubview(btnCancel)
    }

}
