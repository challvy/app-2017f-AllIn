//
//  SignInSignUpViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/21.
//

import UIKit
import os.log

class SignInSignUpViewController: UIViewController, UITextFieldDelegate {

    static let UnWindSignInSignUpSegue = "unwindToContainerWithSender"
    
    //MARK: Properties
    var txtSettingsAccount: UILabel!
    var txtLineMain: UILabel!
    
    var txtAccount: UITextField!
    var txtPassword: UITextField!
    var btnSignIn: UIButton!
    var btnSignUp: UIButton!
    var btnCancel: UIButton!
    
    var user: User?
    var loginState: LoginState = LoginState.NONE
    
    var offsetHand:CGFloat = 60
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    var flagAminiated:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initUI()
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
        if(textField.isEqual(txtAccount)) && flagAminiated==0{
            // edit Account
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                self.imgLeftHand.frame = CGRect(x:self.imgLeftHand.frame.origin.x - self.offsetHand,
                                                y:self.imgLeftHand.frame.origin.y + 30,
                                                width:self.imgLeftHand.frame.size.width,
                                                height:self.imgLeftHand.frame.size.height)
                
                self.imgRightHand.frame = CGRect(x:self.imgRightHand.frame.origin.x + self.offsetHand,
                                                 y:self.imgRightHand.frame.origin.y + 30,
                                                 width:self.imgRightHand.frame.size.width,
                                                 height:self.imgRightHand.frame.size.height)
            })
            flagAminiated = 1
        } else if textField.isEqual(txtPassword) && flagAminiated==1{
            // edit password
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                self.imgLeftHand.frame = CGRect(x: self.imgLeftHand.frame.origin.x + self.offsetHand,
                                                y:self.imgLeftHand.frame.origin.y - 30,
                                                width:self.imgLeftHand.frame.size.width,
                                                height:self.imgLeftHand.frame.size.height)
                
                self.imgRightHand.frame = CGRect(x:self.imgRightHand.frame.origin.x - self.offsetHand,
                                                 y:self.imgRightHand.frame.origin.y - 30,
                                                 width:self.imgRightHand.frame.size.width,
                                                 height:self.imgRightHand.frame.size.height)
            })
            flagAminiated = 0
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
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        guard (button === btnSignIn) || (button === btnSignUp) else {
            os_log("The SignIn SignUp was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }
    
    //MARK: Button Action
    @objc func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
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
                        self.user = user
                        self.performSegue(withIdentifier: SignInSignUpViewController.UnWindSignInSignUpSegue, sender: self.btnSignIn)
                    case .INEXISTENT:
                        DispatchQueue.main.async {
                            self.txtAccount.text = nil
                            self.txtAccount.placeholder = "Non-existent Account"
                            self.updateButtonState()
                        }
                    case .ERR_PASSWORD:
                        DispatchQueue.main.async {
                            self.txtPassword.text = nil
                            self.txtPassword.placeholder = "Incorrect Password"
                            self.updateButtonState()
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
                        self.user = user
                        self.performSegue(withIdentifier: SignInSignUpViewController.UnWindSignInSignUpSegue, sender: self.btnSignIn)
                    case .EXISTENT:
                        DispatchQueue.main.async {
                            self.txtAccount.text = nil
                            self.txtAccount.placeholder = "Existent Account"
                            self.updateButtonState()
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
    
    private func initUI() {
        let mainSize = UIScreen.main.bounds.size
        
        let imgDoreamon = UIImageView(frame: CGRect(x: 30, y: 165, width: mainSize.width-60, height: mainSize.width-60))
        imgDoreamon.image = #imageLiteral(resourceName: "DoraemonImage")
        self.view.addSubview(imgDoreamon)
    
        imgLeftHand = UIImageView(frame: CGRect(x: mainSize.width/2-117, y: 210, width: 120, height: 120))
        imgLeftHand.image = #imageLiteral(resourceName: "leftHandImage")
        self.view.addSubview(imgLeftHand)
        
        imgRightHand = UIImageView(frame: CGRect(x: mainSize.width/2-1, y: 210, width: 120, height: 120))
        imgRightHand.image = #imageLiteral(resourceName: "rightHandImage")
        self.view.addSubview(imgRightHand)
        
        
        // Title
        txtSettingsAccount = UILabel(frame: CGRect(x: 60, y: 23, width: mainSize.width-60, height: 44))
        txtSettingsAccount.text = "Welcome"
        txtSettingsAccount.font = UIFont.systemFont(ofSize: 18)
        txtSettingsAccount.textColor = UIColor(displayP3Red:64/255, green:64/255, blue:64/255, alpha:1)
        txtSettingsAccount.textAlignment = .left
        
        txtLineMain = UILabel(frame: CGRect(x: 15, y: 79, width: mainSize.width-30, height: 1))
        txtLineMain.backgroundColor = UIColor(displayP3Red:65/255, green:171/255, blue:225/255, alpha:1)
        txtLineMain.alignmentRect(forFrame: CGRect(x: 10, y: 120, width: mainSize.width-20, height: 1))
        self.view.addSubview(txtSettingsAccount)
        self.view.addSubview(txtLineMain)
        

        // Content
        let loginBackground =  UIView(frame: CGRect(x: 15, y: 300, width: mainSize.width-30, height: 220))
        loginBackground.layer.borderWidth = 0.5
        loginBackground.layer.borderColor = UIColor.lightGray.cgColor
        loginBackground.backgroundColor = UIColor.white
        loginBackground.layer.cornerRadius = 15
        self.view.addSubview(loginBackground)
        
        
        // >Account text field
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
        
        // >Password text field
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
        
        // >Sign in Button
        btnSignIn = UIButton(frame: CGRect(x: 30+loginBackground.frame.size.width/2-15, y: 150, width: loginBackground.frame.size.width/2-45, height: 44))
        btnSignIn.layer.cornerRadius = 3
        btnSignIn.setTitleColor(UIColor.white, for: .normal)
        btnSignIn.setTitle("Sign In", for: .normal)
        btnSignIn.backgroundColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        btnSignIn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // >Sign up Button
        btnSignUp = UIButton(frame: CGRect(x: 30, y: 150, width: loginBackground.frame.size.width/2-45, height: 44))
        btnSignUp.layer.cornerRadius = 3
        btnSignUp.setTitleColor(UIColor.black, for: .normal)
        btnSignUp.setTitle("Sign Up", for: .normal)
        btnSignUp.backgroundColor = UIColor.lightGray
        btnSignUp.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        loginBackground.addSubview(txtAccount)
        loginBackground.addSubview(txtPassword)
        loginBackground.addSubview(btnSignIn)
        loginBackground.addSubview(btnSignUp)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "ReturnBlueImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        self.view.addSubview(btnCancel)
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
