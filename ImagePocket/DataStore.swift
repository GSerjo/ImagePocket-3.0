//
//  SQLiteDataStore.swift
//  ImagePocket
//
//  Created by Serjo on 03/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation
import SQLite

final class DataStore {
    static let sharedInstance = DataStore()
    
    fileprivate let connection: Connection?
    
    fileprivate init(){
        var path = "NeliburImagePocketDB.sqlite"
        
        if let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString] {
            let dir = dirs[0]
            path = dir.appendingPathComponent("NeliburImagePocketDB.sqlite");
            print(path)
        }
        
        do {
            connection = try Connection(path)
        } catch _ {
            connection = nil
        }
    }
    
    func executeQuery(_ query: String) throws {
        guard let connection =  self.connection else {
            throw DataAccessError.connectionError
        }
        try connection.run(query)
    }
    
    func createTables() throws{
        try ImageRepository.createTable()
        try TagRepository.createTable()
    }
}
