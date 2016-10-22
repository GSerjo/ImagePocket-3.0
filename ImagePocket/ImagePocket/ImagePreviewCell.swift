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
    //@IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate var requestId: PHImageRequestID?
    
    func setImage(_ asset: PHAsset){
        
        let requestOptions = PHImageRequestOptions()
        //requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        //requestOptions.resizeMode = PHImageRequestOptionsResizeMode.Fast
        requestOptions.isNetworkAccessAllowed = true
        //requestOptions.synchronous = false
        /*requestOptions.progressHandler = { [weak self]
         (value: Double, _: NSError?, _ : UnsafeMutablePointer<ObjCBool>, _ : [NSObject : AnyObject]?) in
         self!.activityIndicator.startAnimating()
         }*/
        
        //let targetSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        
        requestId = PHImageManager.default().requestImage(for: asset, targetSize: imageView.frame.size, contentMode: .aspectFill, options: requestOptions){ [weak self](image, options) in
            self!.imageView.image = image
            self!.requestId = nil
            self!.activityIndicator.stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        if let requestId = self.requestId {
            PHImageManager.default().cancelImageRequest(requestId)
        }
        self.activityIndicator.stopAnimating()
        self.imageView.image = nil
    }
}
