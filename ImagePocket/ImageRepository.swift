//
//  ImageRepository.swift
//  ImagePocket
//
//  Created by Serjo on 03/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation
import SQLite

final class ImageRepository {
    
    private static let tableName = "Image"
    private static let table = Table(tableName)
    
    
    static func createTable() throws {
        guard let connection = DataStore.sharedInstance.connection else {
            return
        }
        
        let query = table.create(ifNotExists: true) { t in
            t.column(Columns.id, primaryKey: true)
            t.column(Columns.localIdentifier)
        }
        
        try connection.run(query)
        try connection.run(table.createIndex([Columns.localIdentifier], ifNotExists: true))
    }
    
    private struct Columns {
        static let id = Expression<Int64>("id")
        static let localIdentifier = Expression<String>("localIdentifier")
    }
    
}
