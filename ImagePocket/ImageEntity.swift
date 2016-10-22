//
//  ImageEntity.swift
//  ImagePocket
//
//  Created by Serjo on 07/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation

struct ImageEntity{
    
    fileprivate(set) var tags = [TagEntity]()
    var localIdentifier = String.empty
    
    init(localIdentifier: String){
        self.localIdentifier = localIdentifier
    }
    
    mutating func addTag(_ tag: TagEntity){
        if(containsTag(tag)){
            return
        }
        tags.append(tag)
    }
    
    func containsTag(_ tag: TagEntity) -> Bool{
        return tags.contains(tag)
    }
}
