//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 20/04/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit


// MARK: Regift constants
let frameCount = 16
let delayTime: Float = 0.2
let loopCount = 0 // 0 means loop forever

public class Gif {
    
    let regift : Regift;
    let gifUrl : URL?
    let videoURL: URL?
    let gifImage: UIImage?
   // let gifImageWithCaption: UIImage?
    let gifData: NSData?
    let start: Float?
    let duration:Float?
    let caption: String?
    let font: UIFont?
    
    // New gif from video url
    init(videoURL: URL, start: Float?, duration: Float?, caption: String?, font: UIFont?) {
        // Regift
        self.start = start
        self.duration = duration
        if let start = start {
            //Trimmed
            self.regift = Regift(sourceFileURL: videoURL,
                            destinationFileURL: nil,
                            startTime: start,
                            duration: duration!,
                            frameRate: frameCount,
                            loopCount: loopCount)
            
        } else {
            //Untrimmed
            self.regift = Regift(sourceFileURL:videoURL,
                            frameCount: frameCount,
                            delayTime: delayTime,
                            loopCount: loopCount)
        }
        
        self.gifUrl = regift.createGif()
        
        self.videoURL = videoURL
        if let gifUrl = self.gifUrl {
        self.gifImage = UIImage.gif(url: gifUrl.absoluteString)
            // Add caption
        self.gifData = NSData(contentsOf: gifUrl)
        } else {
            self.gifImage = nil
            self.gifData = nil
        }
       
        
        self.caption = caption
        self.font = font
       
    }
    
    
    
    convenience init (videoURL: URL, start: Float?, duration: Float?) {
        self.init(videoURL: videoURL, start: start, duration: duration, caption: nil, font:nil)
    }
    
    convenience init(oldGif: Gif, caption: String?, font: UIFont?) {
        self.init(videoURL: oldGif.videoURL!, start: oldGif.start, duration: oldGif.duration, caption: caption, font: font)
    }
    
    
    // We can add caption to image but if we want to share a gif we need to put all together
 
}
