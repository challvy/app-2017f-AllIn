//
//  RssXMLParser.swift
//  AllIn
//
//  Created by apple on 2017/12/12.
//

import Foundation

class RssXMLParser: NSObject, XMLParserDelegate {
    
    var isItem: Bool = false
    var curEleCont : String = ""
    var rssItems: [RssItem] = []
    var curTitle: String = ""
    var curLink: String = ""
    var curPubDate: String = ""
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if (elementName == "item"){
            isItem = true
        }
    }
    
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if isItem{
            switch elementName {
            case "item":
                let rssItem: RssItem = RssItem(_title: curTitle, _link: curLink, _pubDate: curPubDate)
                rssItems.append(rssItem)
                isItem = false
            case "title":
                curTitle = self.curEleCont
            case "link":
                curLink = self.curEleCont
            case "pubDate":
                curPubDate = self.curEleCont
            default:
                break
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        self.curEleCont = string
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error){
        print("Error: Rss XML Parser")
    }
    
}
