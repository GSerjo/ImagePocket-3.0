//
//  ViewController.swift
//  ImagePocket
//
//  Created by Serjo on 24/07/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import UIKit
import Photos

final class ViewController: UIViewController {
    
    private struct AppTitle {
        static let Root = "Image Pocket"
        static let Select = "Select Images"
    }
    
    private var viewMode = ViewMode.Read {
        didSet {
            switch viewMode {
            case .Read:
                setReadMode()
            case .Select:
                setSelectMode()
            }
            
        }
    }
    
    private var openMenuButton: UIBarButtonItem!
    private var cancelSelectModeButton: UIBarButtonItem!
    private var tagButton: UIBarButtonItem!
    
    @IBOutlet var seletImageButton: UIBarButtonItem!
    @IBOutlet var shareImageButton: UIBarButtonItem!
    @IBOutlet var removeImageButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolbar()
        setupCollectionView()
        
        viewMode = .Read
        
        try! DataStore.sharedInstance.createTables()
        
        if(PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.Authorized){
            startApp()
        }
        else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    @IBAction func onSelectClicked(sender: UIBarButtonItem) {
        viewMode = .Select
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupCollectionView(){
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        self.collectionView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.collectionViewLayout = layout
    }
    
    
    private func setupToolbar(){
        openMenuButton = MMDrawerBarButtonItem(target: self, action: #selector(onOpenMenuClicked))
        
        tagButton = UIBarButtonItem(title: "Tag", style: .Plain, target: self, action: #selector(onTagClicked))
        cancelSelectModeButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(onCancelSelectModeClicked))
    }
    
    @objc private func onOpenMenuClicked(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @objc private func onTagClicked() {
        
    }
    
    @objc private func onCancelSelectModeClicked() {
        viewMode = .Read
    }
    
    private func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        
        if(status == PHAuthorizationStatus.Authorized){
            executeInMainQueue{self.startApp()}
        }
        else {
            
            let alertController = UIAlertController(title: "Warning", message: "The Photo permission was not authorized. Please enable it in Settings to continue", preferredStyle: .Alert)
            let settingsAction = UIAlertAction(title: "Open Settings", style: .Default, handler: {_ in
                
                if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.sharedApplication().openURL(appSettings)
                }
            })
            
            alertController.addAction(settingsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    private func startApp() {
        
    }
    
    private func executeInMainQueue(action: ()-> Void){
        dispatch_async(dispatch_get_main_queue(), action)
    }
    
    private func setReadMode() {
        title = AppTitle.Root
        removeImageButton.enabled = false
        shareImageButton.enabled = false
        navigationItem.leftBarButtonItem = openMenuButton
        navigationItem.rightBarButtonItem = seletImageButton
    }
    
    private func setSelectMode() {
        title = AppTitle.Select
        navigationItem.leftBarButtonItem = tagButton
        navigationItem.leftBarButtonItem?.enabled = false
        navigationItem.rightBarButtonItem = cancelSelectModeButton
    }
    
    private enum ViewMode {
        case Read
        case Select
    }
}

