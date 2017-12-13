//
//  DigestCel.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation

public class DigestCell: NSObject {
    
    //MARK: Properties
    var rssItem: RssItem
    var isFavorite = false
    var isReaded = false
    
    //MARK: Initialization
    
    init(rssItem: RssItem){
        // Initialize stored properties
        self.rssItem = rssItem
        isFavorite = false
        isReaded = false
    }
}
