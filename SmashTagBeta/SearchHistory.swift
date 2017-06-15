//
//  SearchHistory.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 14/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import Foundation

struct SearchHistory{
    private static var queue = [String]()
    private static let size = 100
    
    static var items: [String]{
        return queue
    }
    
    static func addItem(_ name: String){
        var match = false
        for (index, item) in queue.enumerated(){
            if item.localizedCaseInsensitiveCompare(name) == .orderedSame{
                queue.remove(at: index)
                queue.insert(name, at: 0)
                match = true
                break
            }
        }
        if !match{
            queue.insert(name, at: 0)
        }
        
        if queue.count > size{
            queue.removeSubrange(size..<queue.count)
        }
        print(queue)
    }
    
    static func clear(){
        queue.removeAll()
    }
    
    
}





