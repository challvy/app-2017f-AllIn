//
//  ZhihuDailyHTMLParser.swift
//  AllIn
//
//  Created by apple on 2017/12/27.
//

import Foundation
import UIKit
import Fuzi

class ZhihuDailyHTMLParser: NSObject{
    
    public func parser(data: Data?, insertFunc: (NSAttributedString?, UIImage?) -> Void){
        let html = String.init(data: data!, encoding: String.Encoding.utf8)!
        do {
            let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
            for div in doc.css("div"){
                if(div["class"] == "content") {
                    for divChild in div.children {
                        if let markup = HTMLMarkupParser.markups[divChild.tag ?? ""] {
                            print(divChild.tag ?? "")
                            switch markup {
                            case .ImgMarkup(let parser):
                                if let imgURLString = parser(divChild) {
                                    let imgURL = URL(string: imgURLString)!
                                    let data = try! Data.init(contentsOf: imgURL)
                                    let img = UIImage(data: data)!
                                    insertFunc(nil, img)
                                }
                            case .StrMarkup(let parser):
                                if let attributedStr = parser(divChild) {
                                    insertFunc(attributedStr, nil)
                                }
                            case .PMarkup(let parser):
                                var content: NSMutableAttributedString?
                                var imgSrc: String?
                                (content, imgSrc) = parser(divChild)
                                insertFunc(content, nil)
                                if let imgURLString = imgSrc {
                                    let imgURL = URL(string: imgURLString)!
                                    let data = try! Data.init(contentsOf: imgURL)
                                    let img = UIImage(data: data)!
                                    insertFunc(nil, img)
                                }
                                
                            default:
                                print("Unknown tag")
                            }
                        }
                    }
                }
            }
        } catch {}
    }
}
