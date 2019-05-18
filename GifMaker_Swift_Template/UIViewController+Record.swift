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
import AVFoundation
import AVKit


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
        recordVideoController.allowsEditing = true
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

extension UIViewController: UINavigationControllerDelegate {
    
}

// MARK: - UIViewController: UIImagePickerControllerDelegate

extension UIViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        
        if mediaType == kUTTypeMovie as String {
            // URL Video recorded or selected
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
           
            let startTrim = info[UIImagePickerController.InfoKey.init(rawValue: "_UIImagePickerControllerVideoEditingStart")] as! NSNumber?
            
            let endTrim = info[UIImagePickerController.InfoKey.init(rawValue: "_UIImagePickerControllerVideoEditingEnd")] as! NSNumber?
            
            let duration: NSNumber? = {
                if let endTrim = endTrim{
                    return endTrim.floatValue - startTrim!.floatValue as NSNumber
                } else {
                    return nil
                }
            }()
            
           cropVideoToSquare(videoURL: videoURL as URL, start: startTrim, duration: duration)
           //convertVideoToGif(videoURL: videoURL as URL, start: startTrim?.floatValue, duration: duration?.floatValue)


        }
        
        
    }
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Show GIF methods
    func cropVideoToSquare(videoURL: URL, start: NSNumber?, duration: NSNumber?) {
        
        // Random Video Game
        var randomVideoName : String = String(Int.random(in: 10000 ..< 99999))
        randomVideoName.append(".mov")
        
        // output file
        let docFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let outputPath = URL(fileURLWithPath: docFolder ?? "").appendingPathComponent(randomVideoName)
        if FileManager.default.fileExists(atPath: outputPath.absoluteString) {
            do {
                try FileManager.default.removeItem(atPath: outputPath.absoluteString)
            } catch {
            }
        }
        
        // input file
        let asset = AVAsset(url: videoURL)
        
        let composition = AVMutableComposition()
        composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        // input clip
        let clipVideoTrack: AVAssetTrack = asset.tracks(withMediaType: .video)[0]
        
        // make it square
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: clipVideoTrack.naturalSize.height, height: clipVideoTrack.naturalSize.height)
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: CMTimeMakeWithSeconds(60, preferredTimescale: 30))
        
        // rotate to portrait
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: clipVideoTrack)
        let t1 = CGAffineTransform(translationX: clipVideoTrack.naturalSize.height, y: -(clipVideoTrack.naturalSize.width - clipVideoTrack.naturalSize.height) / 2)
        let t2: CGAffineTransform = t1.rotated(by: CGFloat(Double.pi/2))
        
        let finalTransform: CGAffineTransform = t2
        transformer.setTransform(finalTransform, at: .zero)
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        // export
        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exporter?.videoComposition = videoComposition
        exporter?.outputURL = outputPath
        exporter?.outputFileType = .mov
        
        exporter?.exportAsynchronously(completionHandler: {
            if let squareURL = exporter?.outputURL {
            self.convertVideoToGif(videoURL:squareURL, start: nil, duration: nil)
            print("Exporting done!")
            }
        })
    }

    
    func createPath() -> String{
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let manager = FileManager.default
        var outputURL = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("output").absoluteString
        do {
            try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
        }
        outputURL = URL(fileURLWithPath: outputURL).appendingPathComponent("output.mov").absoluteString
        
        // Remove Existing File
        do {
            try manager.removeItem(atPath: outputURL)
        } catch {
        }
        
        return outputURL
    }
    
    func convertVideoToGif(videoURL: URL,start: Float?, duration: Float?) {
        
        // Background process
        DispatchQueue.main.async() {
            self.dismiss(animated: true, completion: nil)
            //URL we GIF is stored
            let gif = Gif(videoURL: videoURL, start: start, duration: duration)
            self.displayGIF(gif: gif)
        }
    }
    
    func displayGIF(gif: Gif) {
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController

        gifEditorVC.gif = gif
        gifEditorVC.context = self as? SavedGifsViewController
        
        navigationController?.pushViewController(gifEditorVC, animated: true)
    }
}
