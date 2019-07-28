//
//  HomeController.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import UIKit

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var currencytable: UITableView!
    @IBOutlet weak var showHashButton: UIButton!
    
    var user : User!
    
    var currency = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHashButton.setCornerRadious()
        currencytable.register(UINib(nibName: CURRENCY_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CURRENCY_CELL_IDENTIFIER)
        currencyView.layer.cornerRadius = 10.0
        getCurrencyData()
        setupLongPressGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: Private Methods
        // Prepare Long press Gesture
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 0.1
        longPressGesture.delegate = self
        currencytable.addGestureRecognizer(longPressGesture)
    }
    
    func getCurrencyData(){
        if let currencyArray = CurrencyDataManager.shared.getCurrencyDataFromFile(){
            currency = currencyArray
        }
    }
    
    //MARK: UILongPressGesture Handler
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .ended {
            currencyView.isHidden = true
        }else if gestureRecognizer.state == .began{
            let touchPoint = gestureRecognizer.location(in: currencytable)
            if let indexPath = currencytable.indexPathForRow(at: touchPoint) {
                currencyView.isHidden = false
                name.text = currency[indexPath.row].name
                icon.image = UIImage(named: currency[indexPath.row].shortName)
            }
        }
    }
    
    //MARK: UITableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CURRENCY_CELL_IDENTIFIER, for: indexPath) as! currencyCell
        cell.selectionStyle = .none
        cell.currency = currency[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TABLE_HEADER_TITLE
    }
    
    //MARK: IBActions
    
    @IBAction func showhashPressed(_ sender: Any) {
        do{
            let aes = try AES(keyString: user.decryptKey)
            let userHash: String = try aes.decrypt(user.UserHash)
            let alert = UIAlertController(title: "Hash", message: userHash, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }catch{
            print(error)
        }
       
    }
    
}
