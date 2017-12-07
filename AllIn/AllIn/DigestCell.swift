//
//  DigestCel.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation

public class DigestCell: NSObject {
    
    //MARK: Properties
    var title: String
    var abstract: String?
    var isFavorite = false
    var isReaded = false
    
    //MARK: Initialization
    
    init?(title: String, abstract: String?){
        guard !title.isEmpty else{
            return nil
        }
        
        // Initialize stored properties
        self.title = title
        self.abstract = abstract
        self.isFavorite = false
        self.isReaded = false
    }
}
