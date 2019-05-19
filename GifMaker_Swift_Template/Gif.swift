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
    
    let videoURL: URL?
    let start: Float?
    let duration:Float?
    let caption: String?
    let font: UIFont?
    let gifUrl : URL?
    let gifImage: UIImage?
    let gifData: NSData?
    let gifUrlWithCaption: URL?
    let gifImageWithCaption: UIImage?
    let gifDataWithCaption: NSData?
   
    // New gif from video url
    init(videoURL: URL, start: Float?, duration: Float?, caption: String?, font: UIFont?) {
        let regift : Regift;
        // Regift
        self.start = start
        self.duration = duration
        if let start = start {
            //Trimmed
            regift = Regift(sourceFileURL: videoURL,
                            destinationFileURL: nil,
                            startTime: start,
                            duration: duration!,
                            frameRate: frameCount,
                            loopCount: loopCount)
            
        } else {
            //Untrimmed
            regift = Regift(sourceFileURL:videoURL,
                            frameCount: frameCount,
                            delayTime: delayTime,
                            loopCount: loopCount)
        }
        
        self.videoURL = videoURL
        self.caption = caption
        self.font = font
        
        self.gifUrl = regift.createGif()
        if let gifUrl = self.gifUrl {
        self.gifImage = UIImage.gif(url: gifUrl.absoluteString)
            // Add caption
        self.gifData = NSData(contentsOf: gifUrl)
        } else {
            self.gifImage = nil
            self.gifData = nil
        }
       
        
        // If there is caption we are going to create aditional gif
        if let caption = caption {
            self.gifUrlWithCaption = regift.createGif(caption, font: font)
            guard let gifUrlWithCaption = self.gifUrlWithCaption else {
                gifImageWithCaption = nil
                gifDataWithCaption = nil
                return }
            self.gifImageWithCaption = UIImage.gif(url: gifUrlWithCaption.absoluteString)
            self.gifDataWithCaption = NSData(contentsOf: gifUrlWithCaption)
            
        } else {
            gifUrlWithCaption = nil
            gifImageWithCaption = nil
            gifDataWithCaption = nil
       }
       
    }
    
    
    
    convenience init (videoURL: URL, start: Float?, duration: Float?) {
        self.init(videoURL: videoURL, start: start, duration: duration, caption: nil, font:nil)
    }
    
    convenience init(oldGif: Gif, caption: String?, font: UIFont?) {
        self.init(videoURL: oldGif.videoURL!, start: oldGif.start, duration: oldGif.duration, caption: caption, font: font)
    }
    
    
    // We can add caption to image but if we want to share a gif we need to put all together
 
}
