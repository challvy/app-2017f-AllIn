//
//  FeedModel.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation

class FeedModel : NSObject, NSCoding {
    
    //MARK: Properties
    var name: String?
    var url: String?
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let url = "url"
    }
    
    //MARK: Initialization
    init(name: String?, url: String){
        super.init()
        self.name = name
        self.url = url
    }
    
    //MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(url, forKey: PropertyKey.url)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        url = aDecoder.decodeObject(forKey: PropertyKey.url) as? String
    }
}
