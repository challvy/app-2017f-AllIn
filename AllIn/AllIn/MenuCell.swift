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
            MenuCell(title: "All In", image: nil),
            MenuCell(title: "Favorites", image: nil),
            MenuCell(title: "QQ", image: nil),
            MenuCell(title: "Weibo", image: nil)
        ]
    }
}
