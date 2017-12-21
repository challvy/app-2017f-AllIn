//
//  User.swift
//  AllIn
//
//  Created by apple on 2017/12/21.
//

import Foundation

struct User {
    let account: String
    let password: String
}

extension User {
    init?(json: [String: Any]) {
        guard let account = json["account"] as? String,
            let password = json["password"] as? String
            else {
                return nil
        }
        
        self.account = account
        self.password = password
        
        if let rssSources = json["rssSources"] as? [[String: Any]] {
            for each in rssSources {
                let rssSource = MenuCell(json: each)!
                print(rssSource.title)
            }
        }
    }
}
