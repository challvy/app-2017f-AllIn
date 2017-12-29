//
//  SourceCell.swift
//  AllIn
//
//  Created by Apple on 2017/12/29.
//

import Foundation
import UIKit

public class SourceCell: NSObject {
    //MARK: Properties
    var title: String
    var image: UIImage?
    
    //MARK: Initialization
    init(title: String, image: UIImage?){
        self.title = title
        self.image = image
    }
}
