//
//  ZhihuDailyXMLParser.swift
//  AllIn
//
//  Created by Apple on 2017/12/17.
//

import Foundation

class ZhihuDailyXMLParser: NSObject, XMLParserDelegate {
    
    var isItem: Bool = false
    var curEleCont : String = ""
    var curTitle: String = ""
    var curContent: String = ""
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if elementName == "div" {
            if attributeDict["class"] == "content"{
                isItem=true
            }
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if isItem{
            switch elementName {
            case "div":
                curContent = self.curEleCont
            case "/div":
                isItem=false
            default:
                break
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        self.curEleCont = string
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error){
        //parser.abortParsing()
        print("Error: Zhihu Daily XML Parser")
    }
    
}
