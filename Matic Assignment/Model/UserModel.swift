//
//  UserModel.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import Foundation

struct User: Codable {
    let UserName:String
    let PassWord:String
    let UserHash:Data
    let decryptKey:String
}
