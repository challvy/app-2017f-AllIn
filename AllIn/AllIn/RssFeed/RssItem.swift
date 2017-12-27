//
//  RssItem.swift
//  AllIn
//
//  Created by apple on 2017/12/12.
//

import Foundation

class RssItem: NSObject {
    
    static let descriptionLength = 20
    
    //MARK: Properties
    var _title: String
    var _link: String
    var _pubDate: String
    var _source: String? = nil
    //MARK: Initialization
    
    init(_title: String, _link: String, _pubDate: String) {
        self._title = _title
        self._link = _link
        self._pubDate = _pubDate
    }
    
    func setSource(_source: String?) {
        self._source = _source
    }
}
