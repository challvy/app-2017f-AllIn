//
//  SourceManagementViewController.swift
//  AllIn
//
//  Created by Apple on 2017/12/26.
//

import UIKit

class SourceManagementViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    var txtTitle: UITextField!
    var txtSource: UITextField!
    
    var btnReset: UIButton!
    var btnConfirm: UIButton!
    
    var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mainSize = UIScreen.main.bounds.size
        
        let loginBackground =  UIView(frame: CGRect(x: 15, y: 250, width: mainSize.width-30, height: 220))
        loginBackground.layer.borderWidth = 0.5
        loginBackground.layer.borderColor = UIColor.lightGray.cgColor
        loginBackground.backgroundColor = UIColor.white
        loginBackground.layer.cornerRadius = 15
        self.view.addSubview(loginBackground)
        
        // Title text field
        txtTitle = UITextField(frame: CGRect(x: 30, y: 30, width: loginBackground.frame.size.width-60, height: 44))
        txtTitle.delegate = self
        txtTitle.layer.cornerRadius = 5
        txtTitle.layer.borderColor = UIColor.lightGray.cgColor
        txtTitle.tintColor = UIColor.black
        txtTitle.layer.borderWidth = 0.5
        txtTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtTitle.leftViewMode = .always
        txtTitle.placeholder = "Title:"
        txtTitle.adjustsFontSizeToFitWidth = true
        let imgAccount = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgAccount.image = #imageLiteral(resourceName: "TitleImage")
        txtTitle.leftView!.addSubview(imgAccount)
        
        // Source text field
        txtSource = UITextField(frame: CGRect(x: 30, y: 90, width: loginBackground.frame.size.width-60, height: 44))
        txtSource.delegate = self
        txtSource.layer.cornerRadius = 5
        txtSource.layer.borderColor = UIColor.lightGray.cgColor
        txtSource.tintColor = UIColor.black
        txtSource.layer.borderWidth = 0.5
        txtSource.isSecureTextEntry = true
        txtSource.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtSource.leftViewMode = .always
        txtSource.placeholder = "Source:"
        let imgPassword = UIImageView(frame: CGRect.init(x: 11, y: 11, width: 22, height: 22))
        imgPassword.image = #imageLiteral(resourceName: "SourceURLImage")
        txtSource.leftView!.addSubview(imgPassword)
        
        loginBackground.addSubview(txtTitle)
        loginBackground.addSubview(txtSource)
        
        // Reset Button
        btnReset = UIButton(frame: CGRect(x: 30, y: 150, width: loginBackground.frame.size.width/2-45, height: 44))
        btnReset.layer.cornerRadius = 3
        btnReset.setTitleColor(UIColor.black, for: .normal)
        btnReset.setTitle("Reset", for: .normal)
        btnReset.backgroundColor = UIColor.lightGray
        //btnSignIn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // Confirm Button
        btnConfirm = UIButton(frame: CGRect(x: 30+loginBackground.frame.size.width/2-15, y: 150, width: loginBackground.frame.size.width/2-45, height: 44))
        btnConfirm.layer.cornerRadius = 3
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.setTitle("Confirm", for: .normal)
        btnConfirm.backgroundColor = UIColor(displayP3Red:65/256, green:171/256, blue:225/256, alpha:1.0)
        //btnConfirm.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
        // Cancel Button
        btnCancel = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnCancel.setImage(#imageLiteral(resourceName: "CancelImage"), for: .normal)
        btnCancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        loginBackground.addSubview(btnReset)
        loginBackground.addSubview(btnConfirm)
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
