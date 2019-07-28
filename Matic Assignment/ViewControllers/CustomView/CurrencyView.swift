//
//  CurrencyView.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import UIKit

class CurrencyView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
//        Bundle.main.loadNibNamed("CurrencyView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
    }
}
