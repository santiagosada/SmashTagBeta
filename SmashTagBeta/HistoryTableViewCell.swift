//
//  HistoryTableViewCell.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/14/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var HistoryLabel: UILabel!
    
    var searchedItem: String!{
        didSet{
            HistoryLabel.text = searchedItem
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
