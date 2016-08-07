//
//  TagEntity.swift
//  ImagePocket
//
//  Created by Serjo on 07/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation

func ==(left: TagEntity, right: TagEntity) -> Bool{
    return left.id == right.id
}

struct TagEntity: Equatable{
    
    static let all = TagEntity(name: "All", id: -1)
    static let untagged = TagEntity(name: "Untagged", id: -2)
    
    var name = String.empty
    var id: Int64
    
    var isAll: Bool{
        return self == TagEntity.all
    }
    
    var isUntagged: Bool{
        return self == TagEntity.untagged
    }
}