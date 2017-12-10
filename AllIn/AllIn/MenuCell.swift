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
    
    init(title: String, image: UIImage?){
        self.title = title
        self.image = image
    }
    
    static func loadMenuCell() -> [MenuCell] {
        return [
            MenuCell(title: "AllIn", image: #imageLiteral(resourceName: "AllInImage")),
            MenuCell(title: "Favorites", image: #imageLiteral(resourceName: "isFavoriteImage")),
            MenuCell(title: "QQ", image: #imageLiteral(resourceName: "QQImage")),
            MenuCell(title: "Weibo", image: #imageLiteral(resourceName: "WeiboImage"))
        ]
    }
}
