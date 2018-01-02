//
//  DigestCel.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation

public class DigestCell: NSObject, NSCoding {
    
    //MARK: Properties
    var rssItem: RssItem
    var isFavorite = false
    var isReaded = false
    
    //MARK: Types
    struct PropertyKey{
        static let rssItem = "rssItem"
        static let isFavourite = "isFavorite"
        static let isReaded = "isReaded"
    }
    
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
    
    //MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(rssItem, forKey: PropertyKey.rssItem)
        aCoder.encode(isFavorite , forKey: PropertyKey.isFavourite)
        aCoder.encode(isReaded, forKey: PropertyKey.isReaded)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        rssItem = aDecoder.decodeObject(forKey: PropertyKey.rssItem) as! RssItem
        isFavorite = aDecoder.decodeBool(forKey: PropertyKey.isFavourite)
        isReaded = aDecoder.decodeBool(forKey: PropertyKey.isReaded)
    }
}
