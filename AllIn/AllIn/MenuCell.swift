//
//  MenuCell.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import Foundation
import UIKit

struct MenuCell{
    
    let title: String
    let image: UIImage?
    
    init(title: String, image: UIImage?){
        self.title = title
        self.image = image
    }
    
    static func loadMenuCell() -> [MenuCell] {
        return [
            MenuCell(title: "QQ", image: nil),
            MenuCell(title: "Weibo", image: nil),
            MenuCell(title: "CSDN Blog", image: nil)
        ]
    }
}
