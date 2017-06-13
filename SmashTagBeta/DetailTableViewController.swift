//
//  DetailTableViewController.swift
//  SmashTagBeta
//
//  Created by Alonso Garcia Molina on 13/06/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var tweet: Tweet!{
        didSet{
            for (index, media) in tweet.media.enumerated() {
                cells[0][index] = DetailCell(content: .image(media.url.absoluteString))
            }
            for (index, hashtag) in tweet.hashtags.enumerated() {
                cells[1][index] = DetailCell(content: .mention(hashtag.keyword))
            }
            for (index, mention) in tweet.userMentions.enumerated() {
                cells[2][index] = DetailCell(content: .mention(mention.keyword))
            }
            for (index, url) in tweet.urls.enumerated() {
                cells[3][index] = DetailCell(content: .url( url.keyword ))
            }
        }
    }
    
    private enum DetailCellContentType{
        case image(String)
        case mention(String)
        case url(String)
        
        func getContent() -> String{
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
    
    private var cells = [Array<DetailCell>]() //CAMBIAR: inicializar con 4 secciones

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
        return 4 //AAAAAAAHAHAHAH
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return cells[section].count
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextMention", for: indexPath)

        let detailCell = cells[indexPath.section][indexPath.row]
        
        if let imageCell = cell as? ImageTableViewCell{
            let url = URL(fileURLWithPath: detailCell.content.getContent())
            if let data = try? Data(contentsOf: url){
                imageCell.setImage(data: data)
            }
        }
        if let mentionCell = cell as? TextMentionTableViewCell{
            mentionCell.setMentionText(detailCell.content.getContent())
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
