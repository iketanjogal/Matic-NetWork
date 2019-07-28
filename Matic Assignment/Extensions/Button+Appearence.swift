//
//  File.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setCornerRadious(){
        self.layer.cornerRadius = 3.0
    }
    func setBorder(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
    }
}
