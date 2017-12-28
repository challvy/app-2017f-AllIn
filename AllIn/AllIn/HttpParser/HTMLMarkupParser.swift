//
//  HTMLMarkupParser.swift
//  AllIn
//
//  Created by apple on 2017/12/23.
//

import Foundation
import UIKit
import Fuzi

enum Markup {
    case ImgMarkup( (XMLElement) -> String? )
    case NodeSetMarkup( (NodeSet) -> String? )
    case StrMarkup((XMLElement) -> NSMutableAttributedString? )
    case DivMarkup( (XMLElement, String?, ((NSAttributedString?, UIImage?)-> Void)) -> Void)
    case PMarkup( (XMLElement) -> (NSMutableAttributedString?, String?))
}

class HTMLMarkupParser {
    
    static var fontSize: CGFloat = 15
    
    static let markups = [
        
        "div": Markup.DivMarkup(DivMarkup),
        
        "figure": Markup.ImgMarkup(FigureMarkup),
        
        "img": Markup.ImgMarkup(ImgMarkup),
        
        "p": Markup.PMarkup(PMarkup),
        
        "strong": Markup.StrMarkup(StrongMarkup),
        
        "br": Markup.StrMarkup(BrMarkup),
        
    ]
    
    static let paragraphSytle: NSMutableParagraphStyle = NSMutableParagraphStyle()
    
    static let strAttributes = [
        
        "strong": [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize + 1, weight: .bold),
        ],
        
        "normal": [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize),
            NSAttributedStringKey.paragraphStyle: HTMLMarkupParser.paragraphSytle,
        ]
    ]
    
    static private func DivMarkup(div: XMLElement, classValue: String?, insertFunc: ((NSAttributedString?, UIImage?)-> Void)) -> Void {
        // 这个做的思路不太对
        if classValue == "quote-content" {
            let rawString = div.stringValue
            var imgSrc: String?
            let content: NSMutableAttributedString? = NSMutableAttributedString(string: div.stringValue + "\n")
            content?.addAttributes(HTMLMarkupParser.strAttributes["normal"]!, range: NSRange.init(location: 0, length: content!.length))
            for divChild in div.children {
                switch divChild.tag ?? "" {
                case "strong":
                    let strongRange = rawString.searchTargetStringByRegex(targetString: divChild.stringValue)
                    content?.addAttributes(HTMLMarkupParser.strAttributes["strong"]!, range: strongRange[0].range)
                case "img":
                    imgSrc = ImgMarkup(img: divChild)
                    
                default:
                    continue
                }
            }
        }
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
    
    static private func PMarkup(p: XMLElement) -> (NSMutableAttributedString?, String?) {
        // 这个框架貌似对转字符串后的stringvalue分割支持的不是很好，
        //Todo: 用<RE>分割rawXML，然后根据里面的标签来进行定制吧
        let rawString = p.stringValue
        var imgSrc: String?
        let content: NSMutableAttributedString? = NSMutableAttributedString(string: p.stringValue + "\n")
        print(p.stringValue)
        content?.addAttributes(HTMLMarkupParser.strAttributes["normal"]!, range: NSRange.init(location: 0, length: content!.length))
        for pChild in p.children {
            switch pChild.tag ?? "" {
            case "strong":
                let strongRange = rawString.searchTargetStringByRegex(targetString: pChild.stringValue)
                content?.addAttributes(HTMLMarkupParser.strAttributes["strong"]!, range: strongRange[0].range)
            case "img":
                imgSrc = ImgMarkup(img: pChild)
            default:
                continue
            }
        }
        return (content, imgSrc)
    }
    
    static private func StrongMarkup(strong: XMLElement) -> NSMutableAttributedString? {
        var content: NSMutableAttributedString? = nil
        content = NSMutableAttributedString(string: strong.stringValue)
        content!.addAttributes(strAttributes["strong"]!, range: NSRange.init(location: 0, length: content!.length))
        return content
    }
    
    static private func BrMarkup(br: XMLElement) -> NSMutableAttributedString? {
        var content: NSMutableAttributedString? = nil
        content = NSMutableAttributedString(string: br.stringValue)
        content!.addAttributes(strAttributes["normal"]!, range: NSRange.init(location: 0, length: content!.length))
        return content
    }
    
    static public func setParagraphStyleLineSpacing(_ lineSpacing: CGFloat) {
        HTMLMarkupParser.paragraphSytle.lineSpacing = lineSpacing
    }
    
    static public func setFontSize(_ fontSize: CGFloat) {
        HTMLMarkupParser.fontSize = fontSize
    }
}
