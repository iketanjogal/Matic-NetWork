//
//  ViewController.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import UIKit

enum UserStatus {
    case Registered
    case New
}
class LandingController: UIViewController {
    @IBOutlet weak var newAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var status: UserStatus = .New
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newAccountButton.setBorder()
        newAccountButton.setCornerRadious()
        signInButton.setCornerRadious()
    }
    
    //MARK: IBActions
    @IBAction func newAccountPressed(_ sender: Any) {
        status = .New
        performSegue(withIdentifier: GO_TO_SIGNIN, sender: self)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        status = .Registered
        performSegue(withIdentifier: GO_TO_SIGNIN, sender: self)
    }
    
    //MARK: Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_SIGNIN{
            let destinationController = segue.destination as! SignInController
            destinationController.status = status
        }
        
    }
}

