//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 20/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit


public class Gif {
    
    let url : URL
    let videoURL: URL
    let caption: String?
    let gifImage: UIImage?
    let gifData: NSData?
    
    init(url: URL, videoURL: URL, caption: String?) {
        self.url = url
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)!
        self.gifData = NSData(contentsOf: url)
        
        
        
//        do {
//          try self.gifData = Data(contentsOf: url)
//
//        } catch {
//            self.gifData = nil
//        }
        
    
    }
    
//    init(name:String) {
//        self.gifImage = UIImage.gif(name: name)
//    }
    
}
