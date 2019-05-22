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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.image = gif?.gifImageWithCaption
    }
    

    @IBAction func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func shareGif(_ sender: UIButton) {
        var itemsToShare = [NSData]()
        itemsToShare.append((self.gif?.gifData)!)
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityVC, animated: true, completion: nil)
    }
}
