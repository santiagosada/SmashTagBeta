//
//  SearchHistory.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 14/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import Foundation
import CoreData

struct SearchHistory{
    
    private static var queue: [String]{
        get{
            if let dafaultsQueue = defaults.array(forKey: "smashtagSearchHistory"){
                return dafaultsQueue as! [String]
            }
            else{
                return [String]()
            }
        }
        set{
            defaults.set(newValue, forKey: "smashtagSearchHistory")
        }
    }
    
    private static let size = 100
    
    private static let defaults = UserDefaults.standard
    
    static var items: [String]{
        return queue
    }
    
    static func addItem(_ name: String, withTweets tweets: [Tweet]){
        var tempQueue = queue
        var match = false
        
        for (index, item) in tempQueue.enumerated(){
            if item.caseInsensitiveCompare(name) == .orderedSame{
                tempQueue.remove(at: index)
                //tempQueue.insert(name, at: 0)
                match = true
                break
            }
        }
        
        tempQueue.insert(name, at: 0)

        let context = AppDelegate.viewContext
        var query = CDQuery(context: context)
        if !match{
            //tempQueue.insert(name, at: 0)
            print("Match not found | New query")
        }
        else{
            print("Macth Found")
            let request: NSFetchRequest<CDQuery> = CDQuery.fetchRequest()
            request.predicate = NSPredicate(format: "queriedTerm matches[c] %@", name)
            if let fetchResult = try? context.fetch(request), fetchResult.count == 1{
                query = fetchResult[0]
                print("Query pulled from database")
            }
            else{
                print("Query unsuccessful, adding new query")
            }
        }
        
        query.queriedTerm = name
        query.addTweets(tweets)
        print("Tweets added to database")
        
        do{
            try context.save()
            print("Context saved successfully")
        }
        catch{
            print("Error thrown when saving context: \n\(error)")
        }
        
        if tempQueue.count > size{
            tempQueue.removeSubrange(size..<tempQueue.count)
        }
        print(tempQueue)
        queue = tempQueue
    }
    
    static func clear(){
        var tempQueue = queue
        tempQueue.removeAll()
        queue = tempQueue
    }
    
    
}





