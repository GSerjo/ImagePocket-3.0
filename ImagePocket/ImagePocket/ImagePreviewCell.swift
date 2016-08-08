//
//  ImagePreviewCell.swift
//  ImagePocket
//
//  Created by Serjo on 07/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import UIKit
import Photos

class ImagePreviewCell: UICollectionViewCell {

    //let targetSize = CGSize(width: selectedAsset.pixelWidth, height: selectedAsset.pixelHeight)
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(asset: PHAsset){
        
        /*let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.Fast
        requestOptions.networkAccessAllowed = true
        requestOptions.synchronous = false*/
        
        let targetSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: targetSize, contentMode: .AspectFill, options: nil){ [weak self](image, options) in
                self!.imageView.image = image
        }
    }
}