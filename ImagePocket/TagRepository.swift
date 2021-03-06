//
//  TagRepository.swift
//  ImagePocket
//
//  Created by Serjo on 05/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation
import SQLite

final class TagRepository {
    
    fileprivate static let tableName = "Tag"
    fileprivate static let table = Table(tableName)
    
    static func createTable() throws {
        
        let tableQuery = table.create(ifNotExists: true){ t in
            t.column(Columns.id, primaryKey: true)
            t.column(Columns.name)
        }
        
        let indexQuery = table.createIndex([Columns.name], ifNotExists: true)
        
        try DataStore.sharedInstance.executeQuery(tableQuery)
        try DataStore.sharedInstance.executeQuery(indexQuery)
    }
    
    
    fileprivate struct Columns {
        static let id = Expression<Int64>("id")
        static let name = Expression<String>("name")
    }    
}
