//
//  currencyCell.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import UIKit

class currencyCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shortName: UILabel!
    @IBOutlet weak var rupee: UILabel!
    
    var currency: Currency! {
        didSet {
            name.text? = currency.name
            shortName.text? = currency.shortName.uppercased()
            rupee.text? = currency.rupee
            icon.image = UIImage(named: currency.shortName)
        }
    }
}
