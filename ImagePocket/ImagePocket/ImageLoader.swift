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
    
    fileprivate let imageManager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    let returnImageSize = CGSize(width: 600, height: 600)
    
    fileprivate init(){
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
        requestOptions.isNetworkAccessAllowed = true
    }
    
    func updateImage(_ asset: PHAsset, action: @escaping (_ image: UIImage?) -> Void){
        imageManager.requestImage(for: asset, targetSize: returnImageSize, contentMode: .aspectFill, options: requestOptions){ (image, _) in
                action(image)
        }
    }
}
