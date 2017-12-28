//
//  HupuRssParser.swift
//  AllIn
//
//  Created by apple on 2017/12/27.
//

import Foundation
import Fuzi
import UIKit

class HupuRssParser: NSObject{
    
    static let bbsHupu: String = "https://bbs.hupu.com"
    //MARK: Properties
    var rssItems: [RssItem] = []
    var curTitle: String = ""
    var curLink: String = ""
    var curPubDate: String = ""
    
    public func parser(data: Data?){
        if let bbsData = data {
            let html = String.init(data: bbsData, encoding: String.Encoding.utf8)!
            do {
                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
                for bbsHotPit in doc.css("div"){
                    if(bbsHotPit["class"] == "bbsHotPit"){
                        for li in bbsHotPit.xpath("div//li"){
                            if let span = li.firstChild(tag: "span"){
                                for ele in span.children{
                                    switch ele.tag ?? "" {
                                    case "a":
                                        if let title = ele["title"] {
                                            curTitle = title
                                            curLink = HupuRssParser.bbsHupu + ele["href"]!
                                        }
                                    case "em":
                                        curPubDate = ele.stringValue
                                        curPubDate.remove(at: curPubDate.startIndex)
                                    default:
                                        print("HupuRssParser: Don't need to solve it")
                                    }
                                }
                                let rssItem: RssItem = RssItem(_title: curTitle, _link: curLink, _pubDate: curPubDate)
                                rssItems.append(rssItem)
                            }
                        }
                    }
                }
            } catch {}
        }
    }
}
