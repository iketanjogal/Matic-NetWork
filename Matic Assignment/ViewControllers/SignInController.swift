//
//  SignInController.swift
//  Matic Assignment
//
//  Created by jogi on 27/07/19.
//  Copyright © 2019 ketanDemo. All rights reserved.
//

import UIKit
class SignInController: UIViewController {    
   
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var randomHashstring: String = ""
    var userNamePasswordCombo: String = ""
   
    var status: UserStatus!
    var loggedInUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppearence()
        setKeyBoardObserver()
        setTapGestureForKeyBoard()
    }
    
    //MARK: Private Methods
    
    func setTapGestureForKeyBoard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func setKeyBoardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpAppearence(){
        signInButton.setCornerRadious()
        switch status!{
        case UserStatus.Registered:
            signInButton.setTitle(SIGNIN_TITLE, for: .normal)
            title = SIGNIN_TITLE
        case UserStatus.New:
            signInButton.setTitle(REGISTER_TITLE, for: .normal)
            title = REGISTER_TITLE
        }
    }
    
    func registerUser(){
        
        // Generate Random Hash
        randomHashstring = randomHashstring.randomHash()
        
        let UserName = userNameTextField.text!
        let PassWord = passwordTextField.text!
       
        // Generate Username + Password combination
        userNamePasswordCombo = userNamePasswordCombo.generateUsernamePassWordCombo(username: UserName, password: PassWord)
    
        
        do {
            //Encrypt Hash
            let aes = try AES(keyString: userNamePasswordCombo)
            let stringToEncrypt: String = randomHashstring
            let encryptedData: Data = try aes.encrypt(stringToEncrypt)
            
            // Prepared User To be Registered
            let user = User(UserName: UserName, PassWord: PassWord, UserHash: encryptedData, decryptKey: userNamePasswordCombo)
            
            // Register User
            KeychainDataManager.shared.registerAndStoreUserInKeychain(user: user) { (result) in
                switch result {
                case .success(let user):
                    self.loggedInUser = user
                    self.performSegue(withIdentifier: GO_TO_HOME, sender: self)
                case .failure(let err):
                    print(err)
                }
            }
            
        } catch {
            print("\(error)")
        }
    }
    
    // Validating Existing User
    func validateUser(){
        
        let UserName = userNameTextField.text!
        let PassWord = passwordTextField.text!
        
        KeychainDataManager.shared.retriveUserInfoFromKeychain(userName: UserName, password: PassWord) { (result) in
            switch result {
            case .success(let user):
                self.loggedInUser = user
                self.performSegue(withIdentifier: GO_TO_HOME, sender: self)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    //Validating TextField
    func validateTextField() -> Bool{
        
        var isValid = true
        if userNameTextField.text?.count == 0{
            isValid = false
        }else if passwordTextField.text?.count == 0{
            isValid = false
        }else{
            isValid = true
        }
        return isValid
    }
    
    //MARK: IBActions
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if validateTextField(){
            if status == UserStatus.New{
                registerUser()
            }else{
                validateUser()
            }
        }
    }
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            userNameTextField.text = ""
        }else{
            passwordTextField.text = ""
        }
    }
    
    //MARK: Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_HOME {
            let destination = segue.destination as! HomeController
            destination.user = loggedInUser
        }
    }
    
    //MARK: KeyBoard Selectors
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/3
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height/3
            }
        }
    }
    
}
