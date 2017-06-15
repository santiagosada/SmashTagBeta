//
//  SearchHistory.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 14/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import Foundation

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
    
    static func addItem(_ name: String){
        var tempQueue = queue
        var match = false
        
        for (index, item) in tempQueue.enumerated(){
            if item.localizedCaseInsensitiveCompare(name) == .orderedSame{
                tempQueue.remove(at: index)
                tempQueue.insert(name, at: 0)
                match = true
                break
            }
        }
        if !match{
            tempQueue.insert(name, at: 0)
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





