//
//  ExtensionUITextView.swift
//  AllIn
//
//  Created by apple on 2017/12/23.
//

import Foundation
import UIKit

//插入的图片附件的尺寸样式
enum ImageAttachmentMode {
    case `default`  //默认（不改变大小）
    case fitTextLine  //使尺寸适应行高
    case fitTextView  //使尺寸适应textView
}

extension UITextView {
    
    func insertString(_ text: NSAttributedString? ){
        if let attributedStr = text {
            // 获取textview文本，转变成可变文本
            let mutableStr = NSMutableAttributedString(attributedString: self.attributedText)
            // 获取光标位置
            let selectedRange = self.selectedRange
            // 插入文字
            mutableStr.insert(attributedStr, at: selectedRange.location)
            
            // 重新给textview文本
            let newSelectedRange = NSMakeRange(selectedRange.location + attributedStr.length, 0)
            self.attributedText = mutableStr
            self.selectedRange = newSelectedRange
        }
    }
    
    //插入图片
    func insertPicture(_ image:UIImage, mode:ImageAttachmentMode = .default){
            //获取textView的所有文本，转成可变的文本
            let mutableStr = NSMutableAttributedString(attributedString: self.attributedText)
        
            //创建图片附件
            let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
            var imgAttachmentString: NSAttributedString
            imgAttachment.image = image
        
            //设置图片显示方式
            if mode == .fitTextLine {
                //与文字一样大小
                imgAttachment.bounds = CGRect(x: 0, y: -4, width: self.font!.lineHeight, height: self.font!.lineHeight)
            } else if mode == .fitTextView {
                //撑满一行
                let imageWidth = self.frame.width - 10
                let imageHeight = image.size.height/image.size.width*imageWidth
                imgAttachment.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            }
        
            imgAttachmentString = NSAttributedString(attachment: imgAttachment)
        
            //获得目前光标的位置
            let selectedRange = self.selectedRange
            //插入文字
            mutableStr.insert(imgAttachmentString, at: selectedRange.location)
            /*
             //设置可变文本的字体属性
             mutableStr.addAttribute(NSFontAttributeName, value: ,
                                    range: NSMakeRange(0,mutableStr.length))
             */
            //再次记住新的光标的位置
            let newSelectedRange = NSMakeRange(selectedRange.location+1, 0)
        
            //重新给文本赋值
            self.attributedText = mutableStr
            //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
            self.selectedRange = newSelectedRange
        /*
            //移动滚动条（确保光标在可视区域内）
            self.scrollRangeToVisible(newSelectedRange)
 */
    }
}
