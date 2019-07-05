//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 11/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

protocol PreviewViewControllerDelegate {
    func previewViewController(add gif:Gif?)
    func previewViewController(edit gif:Gif?, to gif2:Gif?)
}


class GifPreviewViewController: UIViewController {
    
    var gif: Gif?
    var delegate: PreviewViewControllerDelegate?

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var newCaption: UITextField!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var createAndSaveButton: UIButton!
    
    @IBAction func customBackButtom(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Disable interaction in Storyboard...
        gifImageView.image = gif?.gifImage
        newCaption.text = gif?.caption
        newCaption.isUserInteractionEnabled = false
        
        navigationItem.backBarButtonItem?.title = " "
        
        //color to background the same as the view
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        
        if isGifEditingFromDetail() {
            shareButton.isHidden = true
            createAndSaveButton.setTitle("Done", for: .normal)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: - IBActions
    @IBAction func createAndSave() {
        // Create new Gif with caption
        if let gif = gif {
            let newGif = Gif(oldGif: gif, caption: newCaption.text, font: newCaption.font)
        
            if isGifCreatedFromWelcomeScreen() {
               delegate?.previewViewController(add: newGif)
            } else  {
                delegate?.previewViewController(edit: gif, to: newGif)
            }
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
    
    @objc func saveEditedGif () {
        
    }
    
    func isGifToEdit() -> Bool {
        if let numberOfNavigationsController = navigationController?.viewControllers.capacity  {
            return numberOfNavigationsController > 3
        } else {
            return false
        }
    }
    
    func popToRootViewController () {
        dismiss(animated:true)
    }

}
