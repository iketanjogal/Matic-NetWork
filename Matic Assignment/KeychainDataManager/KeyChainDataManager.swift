//
//  KeyChainDataManager.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeychainDataManager {
    static var shared = KeychainDataManager()
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func registerAndStoreUserInKeychain(user:User,completion: @escaping(Result<User,Error>) -> ()){
        do{
            let data = try encoder.encode(user)
            if KeychainWrapper.standard.set(data, forKey: "\(user.UserName)\(user.PassWord)") {
                completion(.success(user))
                print(USER_SAVED_MESSAGE)
            }else{
                print(USER_NOTSAVED_MESSAGE)
            }
        }catch{
             completion(.failure(error))
        }
    }
    func retriveUserInfoFromKeychain(userName:String, password:String,completion: @escaping (Result<User,Error>) -> ()){
        if let data = KeychainWrapper.standard.data(forKey: "\(userName)\(password)") {
            do{
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            }catch{
                completion(.failure(error))
                print(error)
            }
        }else{
            print(USER_NOTFOUND)
        }
    }
}
