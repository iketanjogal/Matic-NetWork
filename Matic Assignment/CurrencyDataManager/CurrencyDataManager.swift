//
//  CurrencyDataManager.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import Foundation
class CurrencyDataManager {
    static var shared = CurrencyDataManager()
    
    func getCurrencyDataFromFile() -> [Currency]?{
        if let url = Bundle.main.url(forResource:CURRENCY_DATA, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Currency].self, from: data)
                return jsonData
            } catch {
                print("\(error)")
            }
        }
        return nil
    }
}
