//
//  ImageViewController.swift
//  Cassini
//
//  Created by Stephen O'Kennedy on 01/08/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: NSURL?{
        didSet {
            image = nil
            if view.window != nil { //Tells us if the view is on screen
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){
                let contentsOfURL = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL{
                            self.image = UIImage(data: imageData)
                        }else{
                            self.spinner?.stopAnimating()
                        }
                    } else {
                        print("ignore data returned from url : \(url)")
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    private let imageView = UIImageView()
    
    private weak var image: UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    //Small perfromance operations
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
//        imageURL = NSURL(string:DemoURL.Trinity)

    }

}
