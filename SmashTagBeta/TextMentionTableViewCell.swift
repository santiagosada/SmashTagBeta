//
//  TextMentionTableViewCell.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/13/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class TextMentionTableViewCell: UITableViewCell {

    @IBOutlet weak var TextMentionLabel: UILabel!
    
    
    func setMentionText(_ text: String){
        TextMentionLabel.text = text
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
