//
//  SettingAccountViewController.swift
//  AllIn
//
//  Created by Apple on 2017/12/25.
//

import UIKit

class SettingAccountViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    var txtSettingsAccount: UILabel!
    var txtLineMain: UILabel!
    
    var txtCurPassword: UITextField!
    var txtNewPassword: UITextField!
    var txtNewPasswordAgain: UITextField!
    
    var btnConfirm: UIButton!
    var btnReset: UIButton!
    var btnCancel: UIButton!
    
    var user: User?
    
    
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
    
    
    // private functions
    private func initUI(){
        let mainSize = UIScreen.main.bounds.size
        
        // Title
        txtSettingsAccount = UILabel(frame: CGRect(x: 60, y: 23, width: mainSize.width-60, height: 44))
        txtSettingsAccount.text = "Account"
        txtSettingsAccount.font = UIFont.systemFont(ofSize: 18)
        txtSettingsAccount.textColor = UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1)
        txtSettingsAccount.textAlignment = .left
        
        txtLineMain = UILabel(frame: CGRect(x: 15, y: 79, width: mainSize.width-30, height: 1))
        txtLineMain.backgroundColor = UIColor(displayP3Red:65/255, green:171/255, blue:225/255, alpha:1)
        txtLineMain.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: mainSize.width-20, height: 1))
        self.view.addSubview(txtSettingsAccount)
        self.view.addSubview(txtLineMain)
        
        // Content
        let loginBackground =  UIView(frame: CGRect(x: 15, y: 220, width: mainSize.width-30, height: 280))
        loginBackground.layer.borderWidth = 0.5
        loginBackground.layer.borderColor = UIColor.lightGray.cgColor
        loginBackground.backgroundColor = UIColor.white
        loginBackground.layer.cornerRadius = 15
        self.view.addSubview(loginBackground)
        
        // >Current Password text field
        txtCurPassword = UITextField(frame: CGRect(x: 30, y: 30, width: loginBackground.frame.size.width-60, height: 44))
        txtCurPassword.delegate = self
        txtCurPassword.layer.cornerRadius = 5
        txtCurPassword.layer.borderColor = UIColor.lightGray.cgColor
        txtCurPassword.tintColor = UIColor.black
        txtCurPassword.layer.borderWidth = 0.5
        txtCurPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtCurPassword.leftViewMode = .always
        txtCurPassword.placeholder = "Current Password:"
        txtCurPassword.adjustsFontSizeToFitWidth = true
        let imgAccount = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgAccount.image = #imageLiteral(resourceName: "PasswordImage")
        txtCurPassword.leftView!.addSubview(imgAccount)
        
        // >New Password text field
        txtNewPassword = UITextField(frame: CGRect(x: 30, y: 90, width: loginBackground.frame.size.width-60, height: 44))
        txtNewPassword.delegate = self
        txtNewPassword.layer.cornerRadius = 5
        txtNewPassword.layer.borderColor = UIColor.lightGray.cgColor
        txtNewPassword.tintColor = UIColor.black
        txtNewPassword.layer.borderWidth = 0.5
        txtNewPassword.isSecureTextEntry = true
        txtNewPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtNewPassword.leftViewMode = .always
        txtNewPassword.placeholder = "New Password:"
        let imgPassword = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgPassword.image = #imageLiteral(resourceName: "PasswordImage")
        txtNewPassword.leftView!.addSubview(imgPassword)
        
        // >New Password Again text field
        txtNewPasswordAgain = UITextField(frame: CGRect(x: 30, y: 150, width: loginBackground.frame.size.width-60, height: 44))
        txtNewPasswordAgain.delegate = self
        txtNewPasswordAgain.layer.cornerRadius = 5
        txtNewPasswordAgain.layer.borderColor = UIColor.lightGray.cgColor
        txtNewPasswordAgain.tintColor = UIColor.black
        txtNewPasswordAgain.layer.borderWidth = 0.5
        txtNewPasswordAgain.isSecureTextEntry = true
        txtNewPasswordAgain.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtNewPasswordAgain.leftViewMode = .always
        txtNewPasswordAgain.placeholder = "New Password Again:"
        let imgPasswordAgain = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgPasswordAgain.image = #imageLiteral(resourceName: "PasswordImage")
        txtNewPasswordAgain.leftView!.addSubview(imgPasswordAgain)
        
        loginBackground.addSubview(txtCurPassword)
        loginBackground.addSubview(txtNewPassword)
        loginBackground.addSubview(txtNewPasswordAgain)
        
        // >Confirm Button
        btnConfirm = UIButton(frame: CGRect(x: 30+loginBackground.frame.size.width/2-15, y: 210, width: loginBackground.frame.size.width/2-45, height: 44))
        btnConfirm.layer.cornerRadius = 3
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.setTitle("Confirm", for: .normal)
        btnConfirm.backgroundColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        //btnConfirm.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // >Reset Button
        btnReset = UIButton(frame: CGRect(x: 30, y: 210, width: loginBackground.frame.size.width/2-45, height: 44))
        btnReset.layer.cornerRadius = 3
        btnReset.setTitleColor(UIColor.black, for: .normal)
        btnReset.setTitle("Reset", for: .normal)
        btnReset.backgroundColor = UIColor.lightGray
        //btnReset.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "ReturnBlueImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        loginBackground.addSubview(btnConfirm)
        loginBackground.addSubview(btnReset)
        self.view.addSubview(btnCancel)
    }

}
