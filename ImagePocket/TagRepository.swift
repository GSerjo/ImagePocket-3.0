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
    
    private static let tableName = "Tag"
    private static let table = Table(tableName)
    
    static func createTable() throws {
        
        let tableQuery = table.create(ifNotExists: true){ t in
            t.column(Columns.id, primaryKey: true)
        }
        
        try DataStore.sharedInstance.executeQuery(tableQuery)
        
    }
    
    
    private struct Columns {
        static let id = Expression<Int64>("id")
    }    
}