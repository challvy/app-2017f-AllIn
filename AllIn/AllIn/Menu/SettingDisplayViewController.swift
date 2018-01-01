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
    static var txtSize: UILabel!
    
    var txtLineA2: UILabel!
    var pickerSize: UIPickerView!
    
    var txtLineA3: UILabel!
    var btnFont: UIButton!
    static var txtFont: UILabel!
    
    var txtLineA4: UILabel!
    var pickerFont: UIPickerView!
    
    var txtLineA5: UILabel!
    var btnBold: UIButton!
    var isBold: Bool!
    var boldSwitch: UISwitch!
    
    var txtLineA6: UILabel!
    
    var txtOther: UILabel!
    var txtLineB1: UILabel!
    
    let sizePickerViewDelegate = SizePickerViewDelegate()
    let fontPickerViewDelegate = FontPickerViewDegelate()
    
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
        if(boldSwitch.isOn){
            isBold = false;
            boldSwitch.setOn(false, animated: true)
        } else {
            isBold = true;
            boldSwitch.setOn(true, animated: true)
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
        //btnSize.addTarget(self, action: #selector(btnSizeTapped(_:)), for: .touchUpInside)
        
        SettingDisplayViewController.txtSize = UILabel(frame: CGRect(x: 350, y: 55, width: 40, height: 30))
        SettingDisplayViewController.txtSize.textColor = UIColor(displayP3Red:160/255, green:160/255, blue:160/255, alpha:1)
        SettingDisplayViewController.txtSize.font = UIFont.systemFont(ofSize: 16)
        SettingDisplayViewController.txtSize.textAlignment = .right
        
        txtLineA2 = UILabel(frame: CGRect(x: 15, y: 89, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA2.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA2.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        pickerSize = UIPickerView(frame: CGRect(x: 0, y: 170, width: SettingsField.frame.size.width, height: 89))
        pickerSize.dataSource = sizePickerViewDelegate
        pickerSize.delegate = sizePickerViewDelegate
        pickerSize.backgroundColor = UIColor(displayP3Red:254/256, green:254/256, blue:254/256, alpha:1.0)
        
        
        txtLineA3 = UILabel(frame: CGRect(x: 15, y: 179, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA3.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA3.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnFont = UIButton(frame: CGRect(x: 20, y: 180, width: SettingsField.frame.size.width, height: 40))
        btnFont.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnFont.setTitle("Font", for: .normal)
        btnFont.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnFont.contentHorizontalAlignment = .left
        //btnFont.addTarget(self, action: #selector(btnDisplayTapped(_:)), for: .touchUpInside)
        
        SettingDisplayViewController.txtFont = UILabel(frame: CGRect(x: 190, y: 185, width: 205, height: 30))
        SettingDisplayViewController.txtFont.textColor = UIColor(displayP3Red:160/255, green:160/255, blue:160/255, alpha:1)
        SettingDisplayViewController.txtFont.font = UIFont.systemFont(ofSize: 16)
        SettingDisplayViewController.txtFont.textAlignment = .right
        
        txtLineA4 = UILabel(frame: CGRect(x: 15, y: 219, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA4.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA4.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        pickerFont = UIPickerView(frame: CGRect(x: 0, y:300, width: SettingsField.frame.size.width, height: 90))
        pickerFont.delegate = fontPickerViewDelegate
        pickerFont.dataSource = fontPickerViewDelegate
        pickerFont.backgroundColor = UIColor(displayP3Red:254/256, green:254/256, blue:254/256, alpha:1.0)
        self.view.addSubview(pickerFont)
        
        txtLineA5 = UILabel(frame: CGRect(x: 15, y: 309, width: SettingsField.frame.size.width-30, height: 1))
        txtLineA5.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA5.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        btnBold = UIButton(frame: CGRect(x: 20, y: 310, width: SettingsField.frame.size.width, height: 40))
        btnBold.setTitleColor(UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1), for: .normal)
        btnBold.setTitle("Bold", for: .normal)
        btnBold.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnBold.contentHorizontalAlignment = .left
        //btnBold.addTarget(self, action: #selector(btnDisplayTapped(_:)), for: .touchUpInside)
        
        boldSwitch = UISwitch(frame: CGRect(x: 345, y: 395, width: 60, height: 30))
        //boldSwitch.isOn = true
        boldSwitch.addTarget(self, action: #selector(chooseBold(_:)), for: .valueChanged)
        self.view.addSubview(boldSwitch)
        
        txtLineA6 = UILabel(frame: CGRect(x: 0, y: 349, width: SettingsField.frame.size.width, height: 1))
        txtLineA6.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineA6.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        // Other
        txtOther = UILabel(frame: CGRect(x: 15, y: 375, width: SettingsField.frame.size.width-60, height: 20))
        txtOther.text = "Other"
        txtOther.font = UIFont.systemFont(ofSize: 14)
        txtOther.textColor = UIColor(displayP3Red:128/255, green:128/255, blue:128/255, alpha:1)
        txtOther.textAlignment = .left
        
        txtLineB1 = UILabel(frame: CGRect(x: 0, y: 400, width: SettingsField.frame.size.width, height: 1))
        txtLineB1.backgroundColor = UIColor(displayP3Red:235/255, green:235/255, blue:235/255, alpha:1)
        txtLineB1.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: SettingsField.frame.size.width-20, height: 1))
        
        SettingsField.addSubview(txtText)
        SettingsField.addSubview(txtLineA1)
        SettingsField.addSubview(btnSize)
        SettingsField.addSubview(SettingDisplayViewController.txtSize)
        SettingsField.addSubview(txtLineA2)
        SettingsField.addSubview(txtLineA3)
        SettingsField.addSubview(btnFont)
        SettingsField.addSubview(SettingDisplayViewController.txtFont)
        SettingsField.addSubview(txtLineA4)
        SettingsField.addSubview(txtLineA5)
        SettingsField.addSubview(btnBold)
        SettingsField.addSubview(txtLineA6)
        
        SettingsField.addSubview(txtOther)
        SettingsField.addSubview(txtLineB1)
        
        self.view.addSubview(SettingsField)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "ReturnBlueImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        self.view.addSubview(btnCancel)
        self.view.addSubview(pickerSize)
        pickerSize.selectRow(Int(HTMLMarkupParser.fontSize - sizePickerViewDelegate.minSize), inComponent: 0, animated: true)
        pickerFont.selectRow(UIFont.familyNames.index(of: HTMLMarkupParser.fontType) ?? 0, inComponent: 0, animated: true)
    }

}

class SizePickerViewDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var minSize: CGFloat = 8
    var sizeNum: CGFloat = 23
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(sizeNum)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        SettingDisplayViewController.txtSize.text = "\(row + Int(minSize))"
        return "\(row + Int(minSize))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        HTMLMarkupParser.fontSize = CGFloat(row) + minSize
    }
}

class FontPickerViewDegelate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var familyNames = UIFont.familyNames
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return familyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        SettingDisplayViewController.txtFont.text = familyNames[row]
        return familyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        HTMLMarkupParser.fontType = familyNames[row]
    }
}
