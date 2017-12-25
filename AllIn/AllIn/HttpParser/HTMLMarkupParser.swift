//
//  HTMLMarkupParser.swift
//  AllIn
//
//  Created by apple on 2017/12/23.
//

import Foundation
import Fuzi

enum Markup {
    case ImgMarkup( (XMLElement) -> String? )
    case NodeSetMarkup( (NodeSet) -> String? )
    case StrMarkup( (XMLElement) -> NSAttributedString? )
}

class HTMLMarkupParser {
    
    
    static let markups = [
        
        "figure": Markup.ImgMarkup(FigureMarkup),
        
        "img": Markup.ImgMarkup(ImgMarkup),
        
        "p": Markup.StrMarkup(PMarkup),
        
        "strong": Markup.StrMarkup(StrongMarkup)
        
    ]
    
    static private func DivMarkup(div: NodeSet) -> String? {
        return nil
    }
    
    static private func FigureMarkup(figure: XMLElement) -> String? {
        var imgUrl: String? = nil
        for figureChild in figure.children {
            if(figureChild.tag == "img"){
                imgUrl = ImgMarkup(img: figureChild)
                break
            }
        }
        return imgUrl
    }
    
    static private func ImgMarkup(img: XMLElement) -> String? {
        let imgSrc = img.attributes["src"]
        return imgSrc
    }
    
    static private func PMarkup(p: XMLElement) -> NSAttributedString? {
        // 这个框架貌似对转字符串后的stringvalue分割支持的不是很好，
        //Todo: 用<RE>分割rawXML，然后根据里面的标签来进行定制吧
        print(p.rawXML)
        print(p.stringValue)
        var content: NSAttributedString? = nil
        content = NSAttributedString(string: p.stringValue)
        for pChild in p.children {
            print(pChild.rawXML)
        }
        return content
    }
    
    static private func StrongMarkup(strong: XMLElement) -> NSAttributedString? {
        var content: NSAttributedString? = nil
        content = NSAttributedString(string: strong.stringValue)
        return content
    }
}
