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
    
    static func checkItemExist(digestCells: [DigestCell], rssItem: RssItem) -> Bool {
        for digestCell in digestCells {
            if digestCell.rssItem._link == rssItem._link {
                print("Yes it exist")
                return true
            }
        }
        return false
    }
    
    /*
     // Error: digestCells is a let constant
    static func addNewItems(digestCells: [DigestCell], rssItems: [RssItem]){
        for (index, item) in rssItems.enumerated() {
            if(DigestCell.checkItemExist(digestCells: digestCells, rssItem: item)){
                break
            }
            digestCells.insert(DigestCell.init(rssItem: item), at: index)
        }
    }
    */
    
}
