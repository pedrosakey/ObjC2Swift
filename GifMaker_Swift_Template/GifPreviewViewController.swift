//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 11/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

protocol PreviewViewControllerDelegate {
    func addToCollection(gif:Gif?)
}


class GifPreviewViewController: UIViewController {
    
    var gif: Gif?
    var context: PreviewViewControllerDelegate?

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var newCaption: UITextField!
    
    
    @IBAction func customBackButtom(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Disable interaction in Storyboard...
        gifImageView.image = gif?.gifImage
        newCaption.text = gif?.caption
        
        navigationItem.backBarButtonItem?.title = " "
        
        //color to background the same as the view
        navigationController?.navigationBar.barTintColor = view.backgroundColor

    }
    // MARK: - IBActions
    @IBAction func createAndSave() {
        // Create new Gif with caption
        if let gif = gif {
        let newGif = Gif(oldGif: gif, caption: newCaption.text, font: newCaption.font)
        context?.addToCollection(gif: newGif)
        }
        performSegue(withIdentifier: "unwindToSavedGifsVC", sender: nil)
    }
    
    @IBAction func shareGif(_ sender: Any) {
        
        let animatedGif = gif?.gifData
        let itemsToShare = [animatedGif]
        
        
        //UIActivityViewController
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare as [Any] , applicationActivities: nil )
        
        activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        // Present
        navigationController?.present(activityVC, animated: true, completion: nil)
        
    }
    
    func popToRootViewController () {
        dismiss(animated:true)
    }

}
