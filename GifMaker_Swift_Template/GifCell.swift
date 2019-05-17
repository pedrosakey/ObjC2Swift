//
//  GifCell.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 16/05/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    func configureForGif(gif: Gif) {
        gifImageView.image = gif.gifImage
    }
}
