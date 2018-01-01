//
//  FeedManager.swift
//  AllIn
//
//  Created by apple on 2017/12/7.
//

import Foundation
import UIKit

// FeedManager暂时弃用，因为Rss源没找到太多，不具有测试的条件，暂时以Http为主
class FeedManager{

    //MARK: Singleton
    static let sharedFeedManager = FeedManager()
    
    //MARK: Properties
    var dataSource = NSMutableArray()
    
    private init(){
        
    }
    
    func count() -> Int{
        return dataSource.count
    }
    
    //MARK: Model Operation
    func addFeedModel(feedModel: FeedModel!){
        for model: Any in dataSource {
            let feedModelObject = model as! FeedModel
            if feedModel.name == feedModelObject.name{
                return
            }
        }
        dataSource.add(feedModel)
        saveAllFeeds()
    }
    
    func removeFeedModel(at index: Int){
        assert(index>=0 && index<count())
        
        dataSource.removeObject(at: index)
        saveAllFeeds()
    }
    
    func feedModel(at index: Int) -> FeedModel {
        assert(index>=0 && index<count())
        return dataSource[index] as! FeedModel
    }
    
    func saveAllFeeds() {
        let path = String.feedCachePath(isCheck: false)
        if let _path = path {
            do{
            try FileManager.default.removeItem(atPath: _path)
            }catch{
                
            }
        }
        // 归档
        NSKeyedArchiver.archiveRootObject(dataSource, toFile: path!)
    }
    
    func loadAllFeeds() {
        let path = String.feedCachePath()
        if let _path = path{
            if let feedModels = NSKeyedUnarchiver.unarchiveObject(withFile: _path) as? [Any]{
                dataSource.addObjects(from: feedModels)
            }
        }
    }
}

extension String {
    static func feedCachePath(isCheck check: Bool = true) -> String? {
        let path = NSHomeDirectory() + "/Documents/data"
        if(check){
            if FileManager.default.fileExists(atPath: path){
                return path
            } else{
                return nil
            }
        }
        return path
    }
}
