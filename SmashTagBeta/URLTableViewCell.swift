//
//  URLTableViewCell.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/14/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class URLTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ULRMentionLabel: UILabel!
    
    var urlText: String!{
        didSet{
            ULRMentionLabel.text = urlText
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
