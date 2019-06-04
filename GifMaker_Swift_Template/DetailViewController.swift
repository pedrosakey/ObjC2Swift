//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 21/05/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    var gif: Gif?
    
    @IBOutlet weak var shareGifButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.image = gif?.gifImageWithCaption
        
        // Buttom Set up
        shareGifButton.layer.cornerRadius = 5
        shareGifButton.layer.borderWidth = 1
        shareGifButton.layer.borderColor = UIColor.magenta.cgColor
        
        // Hide Nav Bar
        navigationController?.navigationBar.isHidden = true
        
    }
    

    @IBAction func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func shareGif(_ sender: UIButton) {
        var itemsToShare = [NSData]()
        itemsToShare.append((self.gif?.gifDataWithCaption)!)
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityVC, animated: true, completion: nil)
    }
}
