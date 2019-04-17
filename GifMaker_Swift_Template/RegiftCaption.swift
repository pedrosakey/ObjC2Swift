//
//  RegiftCaption.swift
//  GifMaker_Swift_Template
//
//  Created by Gabrielle Miller-Messner on 4/22/16.
//  Modified from http://stackoverflow.com/questions/6992830/how-to-write-text-on-image-in-objective-c-iphone
//

import UIKit
import Foundation
import CoreGraphics

extension Regift {
    
    
    func addCaption(_ image: CGImage, text: NSString, font: UIFont) -> CGImage {
        let image = UIImage(cgImage:image)
        
        // Text attributes
        let color = UIColor.white
        var attributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor):color, convertFromNSAttributedStringKey(NSAttributedString.Key.font):font, convertFromNSAttributedStringKey(NSAttributedString.Key.strokeColor) : UIColor.black, convertFromNSAttributedStringKey(NSAttributedString.Key.strokeWidth) : -4] as [String : Any]
        
        // Get scale factor
        let testSize:CGSize =  text.size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
        let scaleFactor = testSize.height/360
        
        // Apply scale factor to attributes
        let scaledFont: UIFont = UIFont(name: "HelveticaNeue-CondensedBlack", size:image.size.height * scaleFactor)!
        attributes[convertFromNSAttributedStringKey(NSAttributedString.Key.font)] = scaledFont
        
        // Text size
        let size:CGSize =  text.size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
        let adjustedWidth = ceil(size.width)
        let adjustedHeight = ceil(size.height)
        
        // Draw image
        UIGraphicsBeginImageContext(image.size)
        let firstRect = CGRect(x: 0,y: 0,width: image.size.width,height: image.size.height)
        image.draw(in: firstRect)
        
        // Draw text
        let sideMargin = (image.size.width - adjustedWidth)/2.0
        let bottomMargin = image.size.height/6.0
        let textOrigin  = CGPoint(x: sideMargin, y: image.size.height - bottomMargin)
        let secondRect = CGRect(x: textOrigin.x,y: textOrigin.y, width: adjustedWidth, height: adjustedHeight)
        text.draw(with: secondRect, options:.usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes), context:nil)
        
        // Capture combined image and text
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.cgImage!
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
