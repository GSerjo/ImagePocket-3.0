//
//  ImageCache.swift
//  ImagePocket
//
//  Created by Serjo on 07/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation
import Photos

final class ImageCache {
    
    static let sharedInctace = ImageCache()
    
    fileprivate var actualImages = [String:ImageEntity]()
    fileprivate var assets = [String: PHAsset]()
    var currentTag = TagEntity.all
    fileprivate(set) var filteredImages = [ImageEntity]()

    fileprivate init(){
        let fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        assets = getAssets(fetchResult as! PHFetchResult<AnyObject>).toDictionary{$0.localIdentifier}
        actualImages = assets.values.map(createImage).toDictionary{$0.localIdentifier}
    }
    
    func updateFilteredImages(_ tag: TagEntity = TagEntity.all) {
        filteredImages = Array(actualImages.values)
    }
    
    subscript(localIdentifier: String) -> PHAsset?{
        return assets[localIdentifier]
    }
    
    fileprivate func getAssets(_ fetchResult: PHFetchResult<AnyObject>) -> [PHAsset]{
        var assets: [PHAsset] = []
        
        fetchResult.enumerateObjects{(object, id, _) in
            if let asset = object as? PHAsset{
                assets.append(asset)
            }
        }
        return assets
    }
    
    fileprivate func createImage(_ asset: PHAsset) -> ImageEntity{
        let result = ImageEntity(localIdentifier: asset.localIdentifier)
        return result
    }
    
}
