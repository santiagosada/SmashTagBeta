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
    
    //var mediaItem: MediaItem!
    
    var imageURL: URL!{
        didSet{
            if let data = try? Data(contentsOf: imageURL){
                let imageToDisplay = UIImage(data: data)
                TweetDetailImageView.image = imageToDisplay
                let imageWidth = imageToDisplay!.size.width
                let imageHeight = imageToDisplay!.size.height
                let ratio = imageWidth / imageHeight
                print(frame.width)
                let newHeight = frame.width / ratio
                print(newHeight)
                frame.size = CGSize(width: frame.width, height: newHeight)
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
