//
//  PopularTableViewCell.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/17/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var mentionLabel: UILabel!
    
    @IBOutlet weak var mentionCountLabel: UILabel!
    
    var mentionName: String?{
        get{
            return mentionLabel.text
        }
        set{
            mentionLabel.text = newValue
        }
    }
    
    var mentionCount: Int?{
        get{
            return Int(mentionCountLabel.text!)//Maybe arreglar
        }
        set{
            if newValue != nil {
                mentionCountLabel.text = String(newValue!)
            }
        }
    }
    

}
