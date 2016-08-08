//
//  ImageLoader.swift
//  ImagePocket
//
//  Created by Serjo on 07/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation
import Photos


final class ImageLoader {
    
    static let sharedInstance = ImageLoader()
    
    private let imageManager = PHImageManager.defaultManager()
    let requestOptions = PHImageRequestOptions()
    let returnImageSize = CGSize(width: 600, height: 600)
    
    private init(){
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.Exact
        requestOptions.networkAccessAllowed = true
    }
    
    func updateImage(asset: PHAsset, action: (image: UIImage?) -> Void){
        imageManager.requestImageForAsset(asset, targetSize: returnImageSize, contentMode: .AspectFill, options: requestOptions){ (image, _) in
                action(image: image)
        }
    }
}
