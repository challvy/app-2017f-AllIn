//
//  SettingAccountViewController.swift
//  AllIn
//
//  Created by Apple on 2017/12/25.
//

import UIKit

class SettingAccountViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    var txtAccount: UITextField!
    var txtPassword: UITextField!
    var txtPasswordAgain: UITextField!
    
    var btnConfirm: UIButton!
    var btnReset: UIButton!
    var btnCancel: UIButton!
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mainSize = UIScreen.main.bounds.size
        
        // Background
        let loginBackground =  UIView(frame: CGRect(x: 15, y: 220, width: mainSize.width-30, height: 280))
        loginBackground.layer.borderWidth = 0.5
        loginBackground.layer.borderColor = UIColor.lightGray.cgColor
        loginBackground.backgroundColor = UIColor.white
        loginBackground.layer.cornerRadius = 15
        self.view.addSubview(loginBackground)
        
        // Account text field
        txtAccount = UITextField(frame: CGRect(x: 30, y: 30, width: loginBackground.frame.size.width-60, height: 44))
        txtAccount.delegate = self
        txtAccount.layer.cornerRadius = 5
        txtAccount.layer.borderColor = UIColor.lightGray.cgColor
        txtAccount.tintColor = UIColor.black
        txtAccount.layer.borderWidth = 0.5
        txtAccount.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtAccount.leftViewMode = .always
        txtAccount.placeholder = "Account:"
        txtAccount.adjustsFontSizeToFitWidth = true
        let imgAccount = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgAccount.image = #imageLiteral(resourceName: "AccountImage")
        txtAccount.leftView!.addSubview(imgAccount)
        
        // Password text field
        txtPassword = UITextField(frame: CGRect(x: 30, y: 90, width: loginBackground.frame.size.width-60, height: 44))
        txtPassword.delegate = self
        txtPassword.layer.cornerRadius = 5
        txtPassword.layer.borderColor = UIColor.lightGray.cgColor
        txtPassword.tintColor = UIColor.black
        txtPassword.layer.borderWidth = 0.5
        txtPassword.isSecureTextEntry = true
        txtPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPassword.leftViewMode = .always
        txtPassword.placeholder = "Password:"
        let imgPassword = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgPassword.image = #imageLiteral(resourceName: "PasswordImage")
        txtPassword.leftView!.addSubview(imgPassword)
        
        // PasswordAgain text field
        txtPasswordAgain = UITextField(frame: CGRect(x: 30, y: 150, width: loginBackground.frame.size.width-60, height: 44))
        txtPasswordAgain.delegate = self
        txtPasswordAgain.layer.cornerRadius = 5
        txtPasswordAgain.layer.borderColor = UIColor.lightGray.cgColor
        txtPasswordAgain.tintColor = UIColor.black
        txtPasswordAgain.layer.borderWidth = 0.5
        txtPasswordAgain.isSecureTextEntry = true
        txtPasswordAgain.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPasswordAgain.leftViewMode = .always
        txtPasswordAgain.placeholder = "Again:"
        let imgPasswordAgain = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgPasswordAgain.image = #imageLiteral(resourceName: "PasswordImage")
        txtPasswordAgain.leftView!.addSubview(imgPasswordAgain)
        
        
        loginBackground.addSubview(txtAccount)
        loginBackground.addSubview(txtPassword)
        loginBackground.addSubview(txtPasswordAgain)
        
        // Confirm Button
        btnConfirm = UIButton(frame: CGRect(x: 30+loginBackground.frame.size.width/2-15, y: 210, width: loginBackground.frame.size.width/2-45, height: 44))
        btnConfirm.layer.cornerRadius = 3
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.setTitle("Confirm", for: .normal)
        btnConfirm.backgroundColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        //btnConfirm.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // Reset Button
        btnReset = UIButton(frame: CGRect(x: 30, y: 210, width: loginBackground.frame.size.width/2-45, height: 44))
        btnReset.layer.cornerRadius = 3
        btnReset.setTitleColor(UIColor.black, for: .normal)
        btnReset.setTitle("Reset", for: .normal)
        btnReset.backgroundColor = UIColor.lightGray
        //btnReset.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "CancelImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        loginBackground.addSubview(btnConfirm)
        loginBackground.addSubview(btnReset)
        self.view.addSubview(btnCancel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    @objc func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
