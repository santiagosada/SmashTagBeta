//
//  DetailTableViewController.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 13/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    private var cells = Array(repeating: [DetailCell](), count: 4)
    
    
    var tweet: Tweet!{
        didSet{
            print("Tweet set")
            for media in tweet.media {
                cells[0].append( DetailCell(content: .image(media.url.absoluteString)) )
                print(media.url.absoluteString)
            }
            for hashtag in tweet.hashtags {
                cells[1].append( DetailCell(content: .mention(hashtag.keyword)) )
                print(hashtag.keyword)
            }
            for mention in tweet.userMentions {
                cells[2].append( DetailCell(content: .mention(mention.keyword)) )
                print(mention.keyword)
            }
            for url in tweet.urls {
                cells[3].append( DetailCell(content: .url( url.keyword )) )
                print(url.keyword)
            }
        }
    }
    
    private enum DetailCellContentType{
        case image(String)
        case mention(String)
        case url(String)
        
        func get() -> String{
            switch self{
            case .image(let text):
                return text
            case .mention(let text):
                return text
            case .url(let text):
                return text
            }
        }
        
    }
    
    private struct DetailCell{
        var content: DetailCellContentType
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
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        let cellContent = cells[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath)
            if let imageCell = cell as? ImageTableViewCell{
                let url = URL(string: cellContent.content.get())!
                let data = try? Data(contentsOf: url)
                imageCell.setImage(data: data!)
            }
        }
            
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "TextMention", for: indexPath)
            if let mentionCell = cell as? TextMentionTableViewCell{
                mentionCell.setMentionText(cellContent.content.get())
            }
        }
        
        return cell
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
