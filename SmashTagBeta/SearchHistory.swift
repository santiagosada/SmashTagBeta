//
//  SearchHistory.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 14/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import Foundation

struct SearchHistory{
    static var queue = [String](){
        didSet{
            print("Did set search history queue")
        }
    }
    
    static func addItem(_ name: String){
        var match = false
        for item in queue{
            if item.localizedCaseInsensitiveCompare(name) == .orderedSame{
                match = true
                break
            }
        }
        if !match{
            queue.insert(name, at: 0)
        }
        
        if queue.count > 100{
            
        }
        
    }
}
