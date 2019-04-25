//
//  GiftEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 11/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController {
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    var gif: Gif?
    
    @IBAction func gifPreview(_ sender: Any) {
        self.presentPreview(sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            gifImageView.image = gif?.gifImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
     // MARK: - UITextFieldDelegate methods
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textFieldShouldReturn (textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - Preview Gif
    @IBAction func presentPreview(sender:Any?)  {
        // GifPreviewViewController Reference
        let gifPreviewVC = storyboard?.instantiateViewController(withIdentifier: "GifPreviewViewController") as! GifPreviewViewController
        
        // Recreate the gif with the caption
        let newGif = Gif(oldGif: self.gif!, caption: captionTextField.text, font: captionTextField.font)
        self.gif = newGif
        
        // Gif to GifPreviewVC
        gifPreviewVC.gif = gif
        
        navigationController?.pushViewController(gifPreviewVC, animated: true)
        
        
    }
}

// MARK: - Observer and respond to keyboards notifications
// Methods to adjust the keyboard
extension GifEditorViewController {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(GifEditorViewController.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                                         object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GifEditorViewController.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                                         object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if view.frame.origin.y >= 0 {
            view.frame.origin.y -= getKeyboardHeight(notification: notification)
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if (self.view.frame.origin.y < 0) {
            view.frame.origin.y += getKeyboardHeight(notification: notification)
        }
    }
    
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
