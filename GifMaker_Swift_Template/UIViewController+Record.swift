//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 11/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

// MARK: Regift constants
let frameCount = 16
let delayTime: Float = 0.2
let loopCount = 0 // 0 means loop forever




extension UIViewController {
    
    @IBAction func presentVideoOptions(sender: AnyObject) {
        // If I don't have access to camera
        
        // Else
        
       // Action Sheet
        let newGifActionSheet = UIAlertController(title: "Create new GIF", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        //Action Sheet opttions
        let recordVideo = UIAlertAction(title: "Record Video", style: UIAlertAction.Style.default, handler: { _ in
           self.launchVideoCamera()
        })
        
        let chooseFromExisting = UIAlertAction(title: "Choose from existing", style: UIAlertAction.Style.default, handler: { _ in
            self.launchPhotolibrary()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        //Add actions to Action Sheet
        newGifActionSheet.addAction(recordVideo)
        newGifActionSheet.addAction(chooseFromExisting)
        newGifActionSheet.addAction(cancel)
        
        //Present
        self.present(newGifActionSheet, animated: true, completion: nil)
        
    }
    
    
   func launchVideoCamera() {
        
        let recordVideoController = UIImagePickerController()
        recordVideoController.sourceType = UIImagePickerController.SourceType.camera
        recordVideoController.mediaTypes = [kUTTypeMovie as String]
        recordVideoController.allowsEditing = false
        recordVideoController.delegate = self
        
        present(recordVideoController, animated: true, completion: nil)
        
    }
    
    func launchPhotolibrary() {
        
        let photoLibraryController = UIImagePickerController()
        photoLibraryController.sourceType = UIImagePickerController.SourceType.photoLibrary
        photoLibraryController.mediaTypes = [kUTTypeMovie as String]
        photoLibraryController.allowsEditing = false
        photoLibraryController.delegate = self
        
        present(photoLibraryController, animated: true, completion: nil)

    }
    
    
    
    

}

// MARK: - UIViewController: UINavigationControllerDelegate

extension UIViewController: UINavigationControllerDelegate {}

// MARK: - UIViewController: UIImagePickerControllerDelegate

extension UIViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        
        if mediaType == kUTTypeMovie as String {
            // URL Video recorded
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
            dismiss(animated: true, completion: nil)
            convertVideoToGif(videoURL: videoURL as URL)
        }
        
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//GIF conversion methods
    func convertVideoToGif(videoURL: URL) {
        let regift = Regift(sourceFileURL: videoURL, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        //URL we GIF is stored
        let gifURL = regift.createGif()
        let gif = Gif(url: gifURL!, videoURL: videoURL, caption: nil)
        displayGIF(gif: gif)
    }
    
    func displayGIF(gif: Gif) {
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditorVC.gif = gif
        navigationController?.pushViewController(gifEditorVC, animated: true)
    }
}
