//
//  User.swift
//  AllIn
//
//  Created by apple on 2017/12/21.
//
import UIKit
import Foundation

class User: NSObject, NSCoding {
    let account: String
    var password: String
    var rssSources = MenuCell.loadMenuCell()
    //var backgroundImg: UIImage
    
    //MARK: Types
    struct PropertyKey{
        static let account = "account"
        static let password = "password"
        static let rssSources = "rssSources"
    }
    
    //MARK: Initialization
    init(account: String, password: String){
        self.account = account
        self.password = password
    }
    
    init(json: [String: Any]) {
        guard let account = json["account"] as? String,
            let password = json["password"] as? String
            else {
                fatalError("Something maybe wrong")
        }
        
        self.account = account
        self.password = password
        
        if let rssSources = json["rssSources"] as? [[String: Any]] {
            for each in rssSources {
                let rssSource = MenuCell(json: each)!
                self.rssSources.append(rssSource)
            }
        }
    }
    
    //MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(account, forKey: PropertyKey.account)
        aCoder.encode(password , forKey: PropertyKey.password)
        aCoder.encode(rssSources, forKey: PropertyKey.rssSources)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        account = aDecoder.decodeObject(forKey: PropertyKey.account) as! String
        password = aDecoder.decodeObject(forKey: PropertyKey.password) as! String
        rssSources = aDecoder.decodeObject(forKey: PropertyKey.rssSources) as! [MenuCell]
    }
    
    
    
}


