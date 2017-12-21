//
//  SignInSignUpViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/21.
//

import UIKit

class SignInSignUpViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    var txtAccount: UITextField!
    var txtPassword: UITextField!
    
    var loginState: LoginState = LoginState.NONE
    var btnSignIn: UIButton!
    var btnSignUp: UIButton!
    var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mainSize = UIScreen.main.bounds.size
        //登录框背景
        let loginBackground =  UIView(frame: CGRect(x: 15, y: 250, width: mainSize.width-30, height: 220))
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
        txtAccount.layer.borderWidth = 0.5
        txtAccount.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtAccount.leftViewMode = .always
        txtAccount.placeholder = "Account:"
        txtAccount.adjustsFontSizeToFitWidth = true
        let imgAccount = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgAccount.image = UIImage(named: "iconfont-account")
        txtAccount.leftView!.addSubview(imgAccount)
        // Password text field
        txtPassword = UITextField(frame: CGRect(x: 30, y: 90, width: loginBackground.frame.size.width-60, height: 44))
        txtPassword.delegate = self
        txtPassword.layer.cornerRadius = 5
        txtPassword.layer.borderColor = UIColor.lightGray.cgColor
        txtPassword.layer.borderWidth = 0.5
        txtPassword.isSecureTextEntry = true
        txtPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPassword.leftViewMode = .always
        txtPassword.placeholder = "Password:"
        let imgPassword = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgPassword.image = UIImage(named: "iconfont-password")
        txtPassword.leftView!.addSubview(imgPassword)
        
        loginBackground.addSubview(txtAccount)
        loginBackground.addSubview(txtPassword)
        
        // Sign in Button
        btnSignIn = UIButton(frame: CGRect(x: 30, y: 150, width: loginBackground.frame.size.width/2-45, height: 44))
        btnSignIn.layer.cornerRadius = 3
        btnSignIn.setTitleColor(UIColor.white, for: .normal)
        btnSignIn.setTitle("Sign In", for: .normal)
        btnSignIn.backgroundColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        btnSignIn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        // Sign up Button
        btnSignUp = UIButton(frame: CGRect(x: 30+loginBackground.frame.size.width/2-15, y: 150, width: loginBackground.frame.size.width/2-45, height: 44))
        btnSignUp.layer.cornerRadius = 3
        btnSignUp.setTitleColor(UIColor.black, for: .normal)
        btnSignUp.setTitle("Sign Up", for: .normal)
        btnSignUp.backgroundColor = UIColor.lightGray
        btnSignUp.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "CancelImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        loginBackground.addSubview(btnSignIn)
        loginBackground.addSubview(btnSignUp)
        self.view.addSubview(btnCancel)
        
        updateButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.isEqual(txtAccount){
        } else if textField.isEqual(txtPassword) {
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.isEqual(txtAccount)){
            // edit Account
        } else if textField.isEqual(txtPassword){
            // edit
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let account = txtAccount.text, let password = txtPassword.text {
            if account.isEmpty || password.isEmpty {
                loginState = .NONE
            } else{
                txtAccount.text = txtAccount.text!.trimmingCharacters(in: .whitespaces)
                loginState = .COMPLETE
            }
        } else{
            loginState = .NONE
        }
        updateButtonState()
    }
    //MARK: Button Action
    @objc func btnTapped(_ button: UIButton){
        if button.isEqual(btnSignIn) {
            // action for Sign in
            print("action for Sign in")
            
            guard let strAccount = txtAccount.text else {
                txtAccount.placeholder = "Please input your Account"
                return
            }
            guard let strPassword = txtPassword.text else {
                return
            }
            let path = "http://localhost:3000/users/user/"+strAccount+"/"+strPassword
            let params = NSMutableDictionary()
            params["account"] = strAccount
            params["password"] = strPassword
            
            var jsonData: Data? = nil
            do {
                jsonData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
                ServerConnect.httpGetUser(urlPath: path, httpBody: jsonData!){
                    (userSchemaError, user) -> Void in
                    switch userSchemaError {
                    case .NONE:
                        print(user!.account)
                    case .INEXISTENT:
                        DispatchQueue.main.async {
                            self.txtAccount.text = nil
                            self.txtAccount.placeholder = "Non-existent Account"
                        }
                    case .ERR_PASSWORD:
                        DispatchQueue.main.async {
                            self.txtPassword.text = nil
                            self.txtPassword.placeholder = "Incorrect Password"
                        }
                    case .ERR_TASK:
                        print("Some thing maybe missing")
                    case .ERR_JSON_SERIALIZATION:
                        print("Error in Json Serialization")
                    default:
                        print("Error: undefined")
                    }
                }
            } catch {
                fatalError("Error: Json Serialization failed in Sign in")
            }
            
        } else if button.isEqual(btnSignUp) {
            // action for Sign up
            print("action for Sign up")
            
            guard let strAccount = txtAccount.text else {
                txtAccount.placeholder = "Please input your Account"
                return
            }
            guard let strPassword = txtPassword.text else {
                return
            }
            let path = "http://localhost:3000/users/user/"+strAccount+"/"+strPassword
            let params = NSMutableDictionary()
            params["account"] = strAccount
            params["password"] = strPassword
            
            var jsonData: Data? = nil
            do {
                jsonData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
                ServerConnect.httpPostUser(urlPath: path, httpBody: jsonData!){
                    (userSchemaError, user) -> Void in
                    
                    switch userSchemaError {
                    case .NONE:
                        print(user!.account)
                    case .EXISTENT:
                        DispatchQueue.main.async {
                            self.txtAccount.text = nil
                            self.txtAccount.placeholder = "Existent Account"
                        }
                    case .ERR_TASK:
                        print("Some thing maybe missing")
                    case .ERR_JSON_SERIALIZATION:
                        print("Error in Json Serialization")
                    default:
                        print("Error undefined")
                    }
                }
            } catch {
                fatalError("Error: Json Serialization failed in Sign up")
            }
            
        }
    }
    
    //MARK: Private Methods
    private func updateButtonState() {
        btnSignUp.isEnabled = LoginState.COMPLETE==loginState
        btnSignIn.isEnabled = loginState == .COMPLETE
    }

    //MARK: Navigation
    @objc func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

enum LoginState{
    case NONE
    case COMPLETE
}

enum UserSchemaError{
    case NONE
    case EXISTENT
    case INEXISTENT
    case ERR_PASSWORD
    case ERR_TASK
    case ERR_JSON_SERIALIZATION
    case ERR
}
