//
//  CDQuery.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 17/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit
import CoreData

class CDQuery: NSManagedObject {

    
    func addTweets(_ tweets: [Tweet]){
        var identifiers: Set<String> = []
        for tweet in tweets{
            identifiers.insert(tweet.identifier)
        }
        
        var storedIdentifiers: Set<String> = []
        for tweet in self.tweets!{
            storedIdentifiers.insert((tweet as! CDPseudoTweet).id!)
        }
        
        let newIdentifires = identifiers.subtracting(storedIdentifiers)
        
        for identifier in newIdentifires{
            let pseudoTweet = CDPseudoTweet(context: self.managedObjectContext!)
            pseudoTweet.id = identifier
            pseudoTweet.query = self
        }
    }
    
}
