//
//  HTMLMarkupParser.swift
//  AllIn
//
//  Created by apple on 2017/12/23.
//

import Foundation
import Fuzi

class HTMLMarkupParser {
    enum Markup {
        case SetMarkup((NodeSet) -> String)
    }
    
    static let markups = [
    
        "div": Markup.SetMarkup(DivMarkup)
    ]
    
    static private func DivMarkup(div: NodeSet) -> String {
        return ""
    }
    
}
