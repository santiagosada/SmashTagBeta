//
//  ImageViewController.swift
//  SmashTagBeta
//
//  Created by Santiago Sada on 6/14/17.
//  Copyright © 2017 MegaPizza. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
{
    // MARK: Model
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { // if we're on screen
                fetchImage()        // then fetch image
            }
        }
    }
    
    // MARK: Private Implementation
    
    private func fetchImage() {
        if let url = imageURL {
            // this next line of code can throw an error
            // and it also will block the UI entirely while access the network
            // we really should be doing it in a separate thread
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil { // we're about to appear on screen so, if needed,
            fetchImage()  // fetch image
        }
    }
    
    // MARK: User Interface
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            // to zoom we have to handle viewForZooming(in scrollView:)
            scrollView.delegate = self
            // and we must set our minimum and maximum zoom scale
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 1.5
            // most important thing to set in UIScrollView is contentSize
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if image != nil {
                layoutImage(newValue!)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("you're kinda fucked")
        if image != nil {
            layoutImage(image!)
        }
    }
    
    private func layoutImage(_ image: UIImage) {
        let screenWidth = scrollView?.frame.width
        let screenHeight = scrollView?.frame.height
        print("HEEEEEEEEEERE!!!")
        if scrollView != nil {
            let screenRatio = screenWidth! / screenHeight!
            let imageRatio = image.size.width / image.size.height
            if imageRatio > screenRatio { //landscape photo
                let landscapeWidth = screenHeight! * imageRatio
                imageView.frame = CGRect(x: 0, y: 0, width: landscapeWidth, height: screenHeight!)
            } else { //portrait or square
                let portraitHight = screenWidth! / imageRatio
                imageView.frame = CGRect(x: 0, y: 0, width: screenWidth!, height: portraitHight)
            }
            imageView.contentMode = UIViewContentMode.scaleAspectFill
        }
        // careful here because scrollView might be nil
        // (for example, if we're setting our image as part of a prepare)
        // so use optional chaining to do nothing
        // if our scrollView outlet has not yet been set
        scrollView?.contentSize = imageView.frame.size
    }
}

// MARK: UIScrollViewDelegate
// Extension which makes ImageViewController conform to UIScrollViewDelegate
// Handles viewForZooming(in scrollView:)
// by returning the UIImageView as the view to transform when zooming

extension ImageViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

