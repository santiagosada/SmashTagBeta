//
//  TweetTableViewCell.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/13/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    // outlets to the UI components in our Custom UITableViewCell
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    // public API of this UITableViewCell subclass
    // each row in the table has its own instance of this class
    // and each instance will have its own tweet to show
    // as set by this var
    
    var tweet: Tweet? { didSet { updateUI() } }
    // whenever our public API tweet is set
    // we just update our outlets using this method
    
    private func updateUI() {
        colorizeTweetText() //Updates text with the proper colors
        tweetUserLabel?.text = tweet?.user.description
        if let profileImageURL = tweet?.user.profileImageURL {
            // FIXME: blocks main thread
            if let imageData = try? Data(contentsOf: profileImageURL) {
                tweetProfileImageView?.image = UIImage(data: imageData)
            }
        } else {
            tweetProfileImageView?.image = nil
        }
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        } else {
            tweetCreatedLabel?.text = nil
        }
    }
    
    private func colorizeTweetText() {
        if let tweetString = tweet?.text {
            let hashtags = tweet?.hashtags
            let userMentions = tweet?.userMentions
            let links =  tweet?.urls
            
            let hashtagColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)  //light purple
            let userMentionColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0) //blue
            let linkColor = UIColor(red:0.58, green:0.65, blue:0.65, alpha:1.0) //light gray
            
            let stylizedString = NSMutableAttributedString.init(string: tweetString)
            
            if hashtags != nil {
                for hashtag in hashtags! {
                    let hashtagString = hashtag.keyword
                    let range = (tweetString as NSString).range(of: hashtagString)
                    stylizedString.addAttribute(NSForegroundColorAttributeName, value: hashtagColor , range: range)
                }
            }
            
            if userMentions != nil {
                for userMention in userMentions! {
                    let userMentionString = userMention.keyword
                    let range = (tweetString as NSString).range(of: userMentionString)
                    stylizedString.addAttribute(NSForegroundColorAttributeName, value: userMentionColor , range: range)
                }
            }
            
            if links != nil {
                for link in links! {
                    let linkString = link.keyword
                    let range = (tweetString as NSString).range(of: linkString)
                    stylizedString.addAttribute(NSForegroundColorAttributeName, value: linkColor , range: range)
                }
            }
            tweetTextLabel?.attributedText = stylizedString
        }
    }
    
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
    

}
