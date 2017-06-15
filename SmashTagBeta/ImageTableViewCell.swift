//
//  ImageTableViewCell.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/13/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var TweetDetailImageView: UIImageView!
    
    var imageRatio: Double!{
        didSet{
        }
    }
    
    var imageURL: URL!{
        didSet{
            if let data = try? Data(contentsOf: imageURL){
                TweetDetailImageView.image = UIImage(data: data)
            }
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
