//
//  PopularTableViewController.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/17/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit
import CoreData

class PopularTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    var mentions: [(name: String, count: Int)] = []
    
    var queriedTerm: String!{
        didSet{
            let context = AppDelegate.viewContext
            let request: NSFetchRequest<CDMention> = CDMention.fetchRequest()
            
            request.predicate = NSPredicate(format: "(query.queriedTerm matches[c] %@) AND (instances >= 2)", queriedTerm)
            
            request.sortDescriptors = [
                NSSortDescriptor(key: "instances", ascending: false),
                NSSortDescriptor(key: "text", ascending: false)]
            
            if let resultMenions = try? context.fetch(request){
                for mention in resultMenions{
                    mentions.append((mention.text!, Int(mention.instances)))
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mentions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Popular", for: indexPath)

        if let popularCell = cell as? PopularTableViewCell{
            popularCell.mentionName = mentions[indexPath.row].name
            popularCell.mentionCount = mentions[indexPath.row].count
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        
        if let navigationVC = destinationVC as? UINavigationController{
            if navigationVC.visibleViewController != nil{
                destinationVC = navigationVC.visibleViewController!
            }
        }
        
        if let searchVC = destinationVC as? TweetTableViewController{
            if let searchedCell = sender as? PopularTableViewCell{
                searchVC.searchText = searchedCell.mentionName
                searchVC.searchTextField.isHidden = true
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
