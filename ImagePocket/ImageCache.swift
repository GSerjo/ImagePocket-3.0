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
    
    private var actualImages = [String:ImageEntity]()
    private var assets = [String: PHAsset]()
    var currentTag = TagEntity.all
    private(set) var filteredImages = [ImageEntity]()

    private init(){
        let fetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        assets = getAssets(fetchResult).toDictionary{$0.localIdentifier}
        actualImages = assets.values.map(createImage).toDictionary{$0.localIdentifier}
    }
    
    func updateFilteredImages(tag: TagEntity = TagEntity.all) {
        filteredImages = Array(actualImages.values)
    }
    
    subscript(localIdentifier: String) -> PHAsset?{
        return assets[localIdentifier]
    }
    
    private func getAssets(fetchResult: PHFetchResult) -> [PHAsset]{
        var assets: [PHAsset] = []
        
        fetchResult.enumerateObjectsUsingBlock{(object, id, _) in
            if let asset = object as? PHAsset{
                assets.append(asset)
            }
        }
        return assets
    }
    
    private func createImage(asset: PHAsset) -> ImageEntity{
        let result = ImageEntity(localIdentifier: asset.localIdentifier)
        return result
    }
    
}
