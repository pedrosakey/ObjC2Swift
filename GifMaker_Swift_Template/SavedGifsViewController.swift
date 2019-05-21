//
//  SavedGifsViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Pedro Sánchez Castro on 16/05/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class SavedGifsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout, PreviewViewControllerDelegate {
    
    var savedGifs : [Gif] = []
    let cellMargin: CGFloat = 12.0
    
    var gifsFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("/savedGifs")
    }
    
    
    @IBOutlet weak var emptyView: UIStackView!
    @IBOutlet weak var collectioView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       emptyView.isHidden = (savedGifs.count != 0)
       collectioView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read save data
        do {
            if let loadedGifs = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(Data(contentsOf: gifsFilePath)){
                savedGifs = loadedGifs as! [Gif]
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
    // MARK: - CollectionView Delegate and Datasource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedGifs.count
       // return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath) as! GifCell
        let gif = savedGifs [indexPath.item]
        cell.configureForGif(gif: gif)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // Gif Selected
        
        let gif = savedGifs [indexPath.item]
        
        // DetailViewController Reference
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        
        // Gif to GifPreviewVC
        detailVC.gif = gif
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - CollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - (cellMargin * 2.0))/2.0
        return CGSize(width: width, height: width)
    }
    
    // MARK: - Unwind Segues
    @IBAction func unwindToSavedGifsViewController(segue:UIStoryboardSegue) {
        
    }
    
    // MARK: - Preview Delegate
    func addToCollection(gif: Gif?) {
        if let gif = gif {
            savedGifs.append(gif)
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: savedGifs, requiringSecureCoding: false)
                try data.write(to: gifsFilePath)
            } catch {
                print("Couldn't write file")
            }
        }
    }

}
