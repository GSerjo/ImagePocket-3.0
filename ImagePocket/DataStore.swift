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
    
    let connection: Connection?
    
    private init(){
        var path = "NeliburImagePocketDB.sqlite"
        
        if let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as [NSString] {
            let dir = dirs[0]
            path = dir.stringByAppendingPathComponent("NeliburImagePocketDB.sqlite");
            print(path)
        }
        
        do {
            connection = try Connection(path)
        } catch _ {
            connection = nil
        }
    }
}
