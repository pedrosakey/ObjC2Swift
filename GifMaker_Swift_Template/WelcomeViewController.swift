//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 11/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var gifImageView: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        let proofOfConceptGif = UIImage.gif(name: "hotlineBling")
        gifImageView.image = proofOfConceptGif
        
        
        UserDefaults.standard.set(true, forKey: "WelcomeViewSeen")
    }
    
    @IBAction func presentOptions(_ sender: Any) {
        presentVideoOptions()
    }
}
