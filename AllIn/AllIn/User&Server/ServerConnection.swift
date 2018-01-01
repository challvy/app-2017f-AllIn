//
//  ServerConnection.swift
//  AllIn
//
//  Created by apple on 2017/12/21.
//

import Foundation

class ServerConnect: NSObject {
    
    static public func httpGet(request: URLRequest!, callback: @escaping (String, String?)->Void){
        let session = URLSession.shared
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                callback(result as String, nil)
            }
        }
        task.resume()
    }
    
    static public func httpPostUser(urlPath: String, httpBody: Data,
                                    callback: @escaping (UserSchemaError, User?)->Void){
        let session = URLSession.shared
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.timeoutInterval = 5
        
        let task = session.dataTask(with: request) { (data, res, err) in
            if err != nil {
                callback(.ERR_TASK, nil)
            } else {
                let httpRes = res as! HTTPURLResponse
                
                switch httpRes.statusCode {
                case 200:
                    do{
                        let jsonUser = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String: Any]
                        let user = User(json: jsonUser!)
                        callback(.NONE, user)
                    } catch {
                        callback(.ERR_JSON_SERIALIZATION, nil)
                    }
                case 400:
                    callback(.EXISTENT, nil)
                case 300:
                    callback(.ERR, nil)
                default:
                    fatalError("Error: unknown res.status in post user")
                }
            }
        }
        task.resume()
    }
    
    static public func httpGetUser(urlPath: String, httpBody: Data,
                                   callback: @escaping (UserSchemaError, User?)->Void){
        let session = URLSession.shared
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = httpBody
        request.timeoutInterval = 5
        
        let task = session.dataTask(with: request) { (data, res, err) in
            if err != nil {
                callback(.ERR_TASK, nil)
            } else {
                let httpRes = res as! HTTPURLResponse
                switch httpRes.statusCode {
                case 200:
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String: Any]
                        let user = User(json: json!)
                        callback(.NONE, user)
                    } catch {
                        callback(.ERR_JSON_SERIALIZATION, nil)
                    }
                case 300:
                    callback(.ERR_PASSWORD, nil)
                case 400:
                    callback(.ERR, nil)
                case 250:
                    callback(.INEXISTENT, nil)
                default:
                    fatalError("Error: unknown res.status in post user")
                }
            }
        }
        task.resume()
    }
    
    static public func httpPutUser(urlPath: String, httpBody: Data,
                                   callback: @escaping (UserSchemaError, User?)->Void){
        let session = URLSession.shared
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = httpBody
        
        let task = session.dataTask(with: request) { (data, res, err) in
            if err != nil {
                callback(.ERR_TASK, nil)
            } else {
                let httpRes = res as! HTTPURLResponse
                switch httpRes.statusCode {
                case 200:
                    callback(.NONE, nil)
                case 300:
                    callback(.INEXISTENT, nil)
                case 400:
                    callback(.ERR, nil)
                default:
                    fatalError("Error: unknown res.status in post user")
                }
            }
        }
        task.resume()
    }
    
    static public func httpDelRss(urlPath: String, httpBody: Data,
                                   callback: @escaping (UserSchemaError, User?)->Void){
        let session = URLSession.shared
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = httpBody
        
        let task = session.dataTask(with: request) { (data, res, err) in
            if err != nil {
                callback(.ERR_TASK, nil)
            } else {
                let httpRes = res as! HTTPURLResponse
                switch httpRes.statusCode {
                case 200:
                    callback(.NONE, nil)
                case 350:
                    callback(.INEXISTENT, nil)
                case 400:
                    callback(.ERR, nil)
                default:
                    fatalError("Error: unknown res.status in post user")
                }
            }
        }
        task.resume()
    }
    
    static public func httpPutRss(urlPath: String, httpBody: Data,
                                  callback: @escaping (UserSchemaError, User?)->Void){
        let session = URLSession.shared
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = httpBody
        
        let task = session.dataTask(with: request) { (data, res, err) in
            if err != nil {
                callback(.ERR_TASK, nil)
            } else {
                let httpRes = res as! HTTPURLResponse
                switch httpRes.statusCode {
                case 200:
                    callback(.NONE, nil)
                case 350:
                    callback(.INEXISTENT, nil)
                case 400:
                    callback(.ERR, nil)
                case 300:
                    callback(.ERR_TASK, nil)
                default:
                    fatalError("Error: unknown res.status in post user")
                }
            }
        }
        task.resume()
    }
}
