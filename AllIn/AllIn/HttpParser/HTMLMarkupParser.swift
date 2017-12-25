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
        var urlString: String? = nil
        for figureChild in figure.children {
            if(figureChild.tag == "img"){
                urlString = ImgMarkup(img: figureChild)
                break
            }
        }
        return urlString
    }
    
    static private func ImgMarkup(img: XMLElement) -> String? {
        return img.attributes["src"]
    }
    
    static private func PMarkup(p: XMLElement) -> NSAttributedString? {
        var content: NSAttributedString? = nil
        content = NSAttributedString(string: p.stringValue)
        return content
    }
    
    static private func StrongMarkup(strong: XMLElement) -> NSAttributedString? {
        var content: NSAttributedString? = nil
        content = NSAttributedString(string: strong.stringValue)
        return content
    }
}
