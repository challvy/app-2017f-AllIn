//
//  HttpRequest.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation

@objc
protocol HttpRequestDelegate{
    @objc optional func requestFinished(request: HttpRequest!, downloadData: NSMutableData!)
    @objc optional func requestFailed(request: HttpRequest!)
}

class HttpRequest: NSObject, NSURLConnectionDelegate{
    
    //MARK: Properties
    var delegate: HttpRequestDelegate?
    var url: String?
    var connect: NSURLConnection?
    var downloadData: NSMutableData?
    
    //MARK: Initialization
    override init() {
        super.init()
        downloadData = NSMutableData()
    }
    
    //MARK: HtttpRequest
    func startRequest(delegate: HttpRequestDelegate?, url: String!){
        
    }
    
    func cancelRequest() {
    }
    
    //MARK: NSURLConnectionDelegate
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        downloadData!.resetBytes(in: NSRange.init(location: 0, length: downloadData!.length))
        downloadData!.length = 0
        delegate?.requestFailed!(request: self)
    }
    
}
