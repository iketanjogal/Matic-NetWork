//
//  String+Random.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import Foundation
extension String {
    
    func randomHash(length: Int = 20) -> String {
        let base = RANDOM_HASH_BASE
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    func generateUsernamePassWordCombo(username:String, password:String) -> String{
        let baseString = USERNAME_PASSWORD_COMBO_BASE
        let comboString = username+password
        guard let range = comboString.range(of: comboString) else { return "" }
        let result = baseString.replacingCharacters(in: range, with: comboString)
        return result
    }
}
