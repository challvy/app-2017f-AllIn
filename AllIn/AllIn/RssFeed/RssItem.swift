//
//  RssItem.swift
//  AllIn
//
//  Created by apple on 2017/12/12.
//

import Foundation

class RssItem: NSObject, NSCoding {
    
    static let descriptionLength = 20
    
    //MARK: Properties
    var _title: String
    var _link: String
    var _pubDate: String
    var _source: String? = nil
    
    //MARK: Types
    struct PropertyKey{
        static let _title = "_title"
        static let _link = "_link"
        static let _pubDate = "_pubDate"
        static let _source = "_source"
    }
    
    //MARK: Initialization
    init(_title: String, _link: String, _pubDate: String) {
        self._title = _title
        self._link = _link
        self._pubDate = _pubDate
    }
    
    func setSource(_source: String?) {
        self._source = _source
    }
    
    //MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(_title, forKey: PropertyKey._title)
        aCoder.encode(_link, forKey: PropertyKey._link)
        aCoder.encode(_pubDate, forKey: PropertyKey._pubDate)
        aCoder.encode(_source, forKey: PropertyKey._source)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        _title = aDecoder.decodeObject(forKey: PropertyKey._title) as! String
        _link = aDecoder.decodeObject(forKey: PropertyKey._link) as! String
        _pubDate = aDecoder.decodeObject(forKey: PropertyKey._pubDate) as! String
        _source = aDecoder.decodeObject(forKey: PropertyKey._source) as? String
    }
}
