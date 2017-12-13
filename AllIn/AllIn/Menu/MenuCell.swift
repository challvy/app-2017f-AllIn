//
//  MenuCell.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import Foundation
import UIKit

public class MenuCell{
    
    let title: String
    let image: UIImage?
    let urlString: String?
    
    init(title: String, image: UIImage?, urlString: String?){
        self.title = title
        self.image = image
        self.urlString = urlString
    }
    
    static func loadMenuCell() -> [MenuCell] {
        return [
            MenuCell(title: "AllIn", image: #imageLiteral(resourceName: "AllInImage"), urlString: nil),
            MenuCell(title: "Favorites", image: #imageLiteral(resourceName: "isFavoriteImage"), urlString: nil),
            MenuCell(title: "知乎日报", image: nil, urlString: "http://feeds.feedburner.com/zhihu-daily"),
            MenuCell(title: "QQ", image: #imageLiteral(resourceName: "QQImage"),  urlString: nil),
            MenuCell(title: "Weibo", image: #imageLiteral(resourceName: "WeiboImage"),  urlString: nil),
        ]
    }
}
