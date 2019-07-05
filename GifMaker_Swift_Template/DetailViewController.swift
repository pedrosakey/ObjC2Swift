//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 21/05/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func delete(gif: Gif?)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    var gif: Gif?
//    var delegate : DetailViewControllerDelegate?
    var delegate: PreviewViewControllerDelegate?
    
    
    @IBOutlet weak var shareGifButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.image = gif?.gifImageWithCaption
        
        // Buttom Set up
        shareGifButton.layer.cornerRadius = 5
        shareGifButton.layer.borderWidth = 1
        shareGifButton.layer.borderColor = UIColor(hex: "#FF4170FF")?.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    @IBAction func deleteGif(_ sender: Any) {
//        delegate?.delete(gif: gif)
        dismissViewController()
    }
    
    @IBAction func editGif(_ sender: Any) {
        // Gif to Gif Editor Controller
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditorVC.gif = gif
        gifEditorVC.delegate = delegate
        
        // Tengo que respetar el flujo de navigación
        self.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(gifEditorVC, animated: true)
        
    }
    
    
}
