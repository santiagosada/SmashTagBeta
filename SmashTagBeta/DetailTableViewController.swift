//
//  DetailTableViewController.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 13/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit
import SafariServices

class DetailTableViewController: UITableViewController {
    
    private var cellContents = Array(repeating: [DetailContentType](), count: 4)
    
    
    var tweet: Tweet!{
        didSet{
            print("Tweet set")
            for media in tweet.media {
                //cellContents[0].append( media.url.absoluteString )
                cellContents[0].append( DetailContentType.media(media) )
                print(media.url.absoluteString)
            }
            for hashtag in tweet.hashtags {
                //cellContents[1].append( hashtag.keyword )
                cellContents[1].append( DetailContentType.hashtag(hashtag) )
                print(hashtag.keyword)
            }
            for mention in tweet.userMentions {
                //cellContents[2].append( mention.keyword )
                cellContents[2].append( DetailContentType.mention(mention) )
                print(mention.keyword)
            }
            for url in tweet.urls {
                //cellContents[3].append( url.keyword )
                cellContents[3].append( DetailContentType.url(url) )
                print(url.keyword)
            }
        }
    }
    
    //private struct DetailContent{
    //    var contentType: DetailContentType
    //}
    
    private enum DetailContentType{
        case media(MediaItem)
        case hashtag(Mention)
        case mention(Mention)
        case url(Mention)
        
        func getMedia() -> MediaItem?{
            switch self{
            case .media(let mediaItem):
                return mediaItem
            default:
                return nil
            }
        }
        func getMention() -> Mention?{
            switch self{
            case .hashtag(let mention), .mention(let mention), .url(let mention):
                return mention
            default:
                return nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cellContents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContents[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        let cellContent = cellContents[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath)
            if let imageCell = cell as? ImageTableViewCell{
                //let url = URL(string: cellContent.content.get())!
                let url = cellContent.getMedia()!.url
                imageCell.imageURL = url
                //imageCell.mediaItem = cellContent.getMedia()!
            }
        }
            
        else if indexPath.section == 3{
            cell = tableView.dequeueReusableCell(withIdentifier: "URLMention", for: indexPath)
            if let urlCell = cell as? URLTableViewCell{
                //mentionCell.setMentionText(cellContent.content.get())
                urlCell.url = URL(string: cellContent.getMention()!.keyword)
            }
        }
            
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "TextMention", for: indexPath)
            if let mentionCell = cell as? TextMentionTableViewCell{
                //mentionCell.setMentionText(cellContent.content.get())
                mentionCell.mentionText = cellContent.getMention()!.keyword
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitles = ["Media", "Hashtags", "Mentions", "URLs"]
        if !cellContents[section].isEmpty{
            return sectionTitles[section]
        }
        else{
            return nil
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        
        if let imageVC = destinationVC as? ImageViewController{
            if let cell = sender as? ImageTableViewCell{
                imageVC.imageURL = cell.imageURL
            }
        }
        
        if let searchVC = destinationVC as? TweetTableViewController{
            if let cell = sender as? TextMentionTableViewCell{
                searchVC.searchText = cell.mentionText
                searchVC.searchTextField.isHidden = true
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3{
            if let url = URL(string: cellContents[indexPath.section][indexPath.row].getMention()!.keyword){
                let svc = SFSafariViewController(url: url)
                present(svc, animated: true, completion: nil)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
