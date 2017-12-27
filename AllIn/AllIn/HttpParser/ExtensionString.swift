//
//  ExtensionString.swift
//  AllIn
//
//  Created by apple on 2017/12/27.
//

import Foundation

extension String {
    func searchTargetStringByRegex (targetString: String) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: targetString, options: .caseInsensitive)
            let result = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
            return result
        } catch {
            return [NSTextCheckingResult]()
        }
    }
}
