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

    private let rootTitle = "Image Pocket"
    
    private var openMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var seletImageButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = rootTitle
        configureToolbar()
        try! DataStore.sharedInstance.createTables()
        
        if(PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.Authorized){
            startApp()
        }
        else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    @IBAction func onSelectClicked(sender: UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func configureToolbar(){
        openMenuButton = MMDrawerBarButtonItem(target: self, action: #selector(onOpenMenuClicked))
        navigationItem.leftBarButtonItem = openMenuButton

    }
    
    @objc private func onOpenMenuClicked(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    private func requestAuthorizationHandler(status: PHAuthorizationStatus) {
    }
    
    private func startApp() {
        
    }
}

