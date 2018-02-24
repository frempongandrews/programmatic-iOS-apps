//
//  PhotoSelectorVC.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 20/02/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var images = [UIImage]()
    var assets = [PHAsset]()
    var selectedImageIndex = 0
    
    func registerCells () {
        
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        //header
        
        collectionView?.register(PhotoSelectorHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    fileprivate func setupCancelAndNextButtons () {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(onNext))
    }
    
    @objc func onCancel () {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onNext () {
        print("Next")
    }
    
    func fetchPhotos () {
        
        print("fetching photos")
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        
        //setting order of images
        let sortDescriptors = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptors]
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        allPhotos.enumerateObjects { (asset, count, stop) in
            
            //print(asset)
            
            let imageManager = PHImageManager()
            
            let targetSize = CGSize(width: 600, height: 600)
            
            //load images in order
            
            let imageOptions = PHImageRequestOptions()
            imageOptions.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: imageOptions, resultHandler: { (image, info) in
                
                if let image = image {
                    
                    self.images.append(image)
                    self.assets.append(asset)
                    
                }
                
            })
            
            
            
        }//end enumerate objects
        
        
        
    }//end fetchPhotos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        setupCancelAndNextButtons()
        
        registerCells()
        
        fetchPhotos()
        
    }//end viewDidLoad

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
}//End PhotoSelectorVC



extension PhotoSelectorVC {
    
    
    //header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeaderCell
       
        header.imageView.image = self.images[selectedImageIndex]
        
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = view.frame.width
        return CGSize(width: width, height: width)
        
    }
    
    
    //end header
    
    
    
    //collectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        //cell.backgroundColor = .red
        
        let image = self.images[indexPath.item]
        //setting image for cell
        cell.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImageIndex = indexPath.item
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        collectionView.reloadData()
    }
    
    
    //end collectionView
    
    
    
    
    
}


























