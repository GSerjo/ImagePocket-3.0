//
//  ViewController.swift
//  ImagePocket
//
//  Created by Serjo on 24/07/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import UIKit
import Photos

final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate var imageCache: ImageCache!
    
    fileprivate struct AppTitle {
        static let Root = "Image Pocket"
        static let Select = "Select Images"
    }
    
    fileprivate var viewMode = ViewMode.read {
        didSet {
            switch viewMode {
            case .read:
                setReadMode()
            case .select:
                setSelectMode()
            }
            
        }
    }
    
    
    fileprivate var openMenuButton: UIBarButtonItem!
    fileprivate var cancelSelectModeButton: UIBarButtonItem!
    fileprivate var tagButton: UIBarButtonItem!
    
    @IBOutlet var seletImageButton: UIBarButtonItem!
    @IBOutlet var shareImageButton: UIBarButtonItem!
    @IBOutlet var removeImageButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let model = Model()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.buildDataSource()
        
        setupToolbar()
        setupCollectionView()
        
        viewMode = .read
        
        try! DataStore.sharedInstance.createTables()
        
        if(PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized){
            startApp()
        }
        else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    @IBAction func onSelectClicked(_ sender: UIBarButtonItem) {
        viewMode = .select
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupCollectionView(){
        /*
         let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        */
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.itemSize = CGSize(width: 160, height: 160)
        
        self.collectionView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.collectionViewLayout = layout
        
        //collectionView.registerClass(ImagePreviewCell.self, forCellWithReuseIdentifier: "ImagePreviewCell")
        //let viewNib = UINib(nibName: "ImagePreviewCell", bundle: nil)
        //collectionView.registerNib(viewNib, forCellWithReuseIdentifier: "ImagePreviewCell")
    }
    
    
    fileprivate func setupToolbar(){
        openMenuButton = MMDrawerBarButtonItem(target: self, action: #selector(onOpenMenuClicked))
        
        tagButton = UIBarButtonItem(title: "Tag", style: .plain, target: self, action: #selector(onTagClicked))
        cancelSelectModeButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancelSelectModeClicked))
    }
    
    @objc fileprivate func onOpenMenuClicked(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    @objc fileprivate func onTagClicked() {
        
    }
    
    @objc fileprivate func onCancelSelectModeClicked() {
        viewMode = .read
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imageCache.filteredImages.count
        //return model.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePreviewCell", for: indexPath) as! ImagePreviewCell
        let entity = imageCache.filteredImages[(indexPath as NSIndexPath).item]
        guard let asset = ImageCache.sharedInctace[entity.localIdentifier] else {
            return cell
        }
        //ImageLoader.sharedInstance.updateImage(asset) { cell.imageView.image = $0 }
        cell.setImage(asset)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        navigationController?.pushViewController(PhotoViewController(), animated: false)
    }
    
   
    fileprivate func requestAuthorizationHandler(_ status: PHAuthorizationStatus) {
        
        if(status == PHAuthorizationStatus.authorized){
            executeInMainQueue{self.startApp()}
        }
        else {
            
            let alertController = UIAlertController(title: "Warning", message: "The Photo permission was not authorized. Please enable it in Settings to continue", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Open Settings", style: .default, handler: {_ in
                
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.openURL(appSettings)
                }
            })
            
            alertController.addAction(settingsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    fileprivate func startApp() {
        imageCache = ImageCache.sharedInctace
        imageCache.updateFilteredImages()
    }
    
    fileprivate func executeInMainQueue(_ action: @escaping ()-> Void){
        DispatchQueue.main.async(execute: action)
    }
    
    fileprivate func setReadMode() {
        title = AppTitle.Root
        removeImageButton.isEnabled = false
        shareImageButton.isEnabled = false
        navigationItem.leftBarButtonItem = openMenuButton
        navigationItem.rightBarButtonItem = seletImageButton
    }
    
    fileprivate func setSelectMode() {
        title = AppTitle.Select
        navigationItem.leftBarButtonItem = tagButton
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = cancelSelectModeButton
    }
    
    fileprivate enum ViewMode {
        case read
        case select
    }
}

