//
//  MenuCell.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import Foundation
import UIKit
import os.log

public class MenuCell: NSObject, NSCoding {
    
    static let rssSourceIcon = [
        "AllIn": #imageLiteral(resourceName: "AllInImage"),
        "QQ": #imageLiteral(resourceName: "QQImage"),
        "Favorites": #imageLiteral(resourceName: "isFavoriteImage"),
        "ZhihuDaily":  #imageLiteral(resourceName: "ZhihuDailyImage"),
        "Weibo":  #imageLiteral(resourceName: "WeiboImage"),
    ]
    
    //MARK: Properties
    var title: String
    var image: UIImage?
    var urlString: String?
    
    //MARK: Types
    struct PropertyKey {
        static let title = "name"
        static let image = "image"
        static let urlString = "urlString"
    }
    
    //MARK: Initialization
    init(title: String, image: UIImage?, urlString: String?){
        self.title = title
        self.image = image
        self.urlString = urlString
    }
    
    init?(json: [String: Any]){
        guard let title = json["title"] as? String,
            let urlString = json["urlString"] as? String
            else{
                return nil
        }
        self.title = title
        self.urlString = urlString
    }
    
    //MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(urlString, forKey: PropertyKey.urlString)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else{
            os_log("Unable to decode the title for a MenuCell object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.title = title
        image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        urlString = aDecoder.decodeObject(forKey: PropertyKey.urlString) as? String
    }
    
    static func loadMenuCell() -> [MenuCell] {
        return [
            MenuCell(title: "AllIn", image: #imageLiteral(resourceName: "AllInImage"), urlString: nil),
            MenuCell(title: "Favorites", image: #imageLiteral(resourceName: "isFavoriteImage"), urlString: nil),
            MenuCell(title: "知乎日报", image: #imageLiteral(resourceName: "ZhihuDailyImage"), urlString: "http://feeds.feedburner.com/zhihu-daily"),
        ]
    }
}
