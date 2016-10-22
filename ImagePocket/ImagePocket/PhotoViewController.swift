//
//  PhotoViewController.swift
//  ImagePocket
//
//  Created by Serjo on 09/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import UIKit

final class PhotoViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabButton = UIBarButtonItem(title: "Tag", style: .plain, target: self, action: #selector(onTagClicked))
        navigationItem.rightBarButtonItem  = tabButton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTagClicked(){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
