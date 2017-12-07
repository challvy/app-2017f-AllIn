//
//  ContentViewControllerDelegate.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation

protocol ContentViewControllerDelegate {
    func didBackFromContent(_ isChanged: Bool, digestCell: DigestCell)
}
