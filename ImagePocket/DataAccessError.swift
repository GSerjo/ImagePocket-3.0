//
//  DataAccessError.swift
//  ImagePocket
//
//  Created by Serjo on 03/08/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation

enum DataAccessError: ErrorType {
    case ConnectionError
    case InsertError
    case DeleteError
}