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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureToolbar()
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
    
    
    private func configureToolbar(){
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
    }
    
    private func startApp() {
        
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
        removeImageButton.enabled = true
        shareImageButton.enabled = true
        navigationItem.leftBarButtonItem = tagButton
        navigationItem.rightBarButtonItem = cancelSelectModeButton
    }
    
    private enum ViewMode {
        case Read
        case Select
    }
}

