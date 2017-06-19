//
//  CDQuery.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 17/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit
import CoreData

public class CDQuery: NSManagedObject {

    
    func addTweets(_ tweetss: [Tweet]){
        print("addTweets called")
        
        //Filter to find new tweets
        var newTweets: [Tweet] = []
        let storedTweets = self.tweets as! Set<CDPseudoTweet>
        
        if self.tweets == nil || self.tweets?.count == 0{
            let newTweet = CDPseudoTweet(context: self.managedObjectContext!)
            newTweet.id = ""
            self.addToTweets(newTweet)
            print("Adding First time empty tweet: ")
        }
        
        
        breakable: for tweet in tweetss{
                for storedTweet in storedTweets{
                    if tweet.identifier == storedTweet.id{
                        continue breakable
                    }
                }
            
                let newTweet = CDPseudoTweet(context: self.managedObjectContext!)
                newTweet.id = tweet.identifier
                self.addToTweets(newTweet)
                newTweets.append(tweet)
                print("New tweet found: \(tweet.identifier)")
        }
        
        if self.mentions == nil || self.mentions?.count == 0{
            let emptyMention = CDMention(context: self.managedObjectContext!)
            emptyMention.text = ""
            self.addToMentions(emptyMention)
        }
        
        for tweet in newTweets{
            let mentions = tweet.hashtags + tweet.userMentions
            breakable: for mention in mentions{
                
                for storedMention in self.mentions as! Set<CDMention>{
                    let text = storedMention.text!
                    if text.caseInsensitiveCompare(mention.keyword) == .orderedSame{
                        storedMention.instances += 1
                        print("Mention found: \(mention.keyword) with \(storedMention.instances) instances")
                        continue breakable
                    }
                }
                
                let newMention = CDMention(context: self.managedObjectContext!)
                newMention.text = mention.keyword
                newMention.instances = 1
                self.addToMentions(newMention)
                print("New Mention added: \(mention.keyword)")
                
            }
        }

        
    }
    
}














