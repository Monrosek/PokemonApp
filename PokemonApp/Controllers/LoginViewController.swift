//
//  LoginViewController.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit
import FirebaseCore
import SwiftKeychainWrapper
import LocalAuthentication

class LoginViewController: UIViewController {
    
    
    @IBOutlet var passField: UITextField!
    @IBOutlet var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passField.delegate = self
        // Do any additional setup after loading the view.
        guard let email = UserDefaults.standard.object(forKey: k.UserNameKey) as? String else {return}
        emailField.text = email
        
        guard LoginInfo.shared.isLoggedIn else {return}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func logInToFirebase(){
        LoginInfo.shared.sharedAuth.signIn(withEmail: emailField.text!, password: passField.text!){
            (user, error) in
            guard error == nil else {
                Alert.Send(self, error!.localizedDescription)
                return
            }
            guard let user = user else {return}
            guard let email = user.email else {return}
            LoginInfo.shared.user = User(email: email, uid: user.uid)
            
            //User Defaults
            //UserDefaults.standard is empty usually
            let userDefault = UserDefaults.standard
            //Saving Username to UserDefaults on device
            userDefault.set(email, forKey: k.UserNameKey)
            
            //Ask user if they want to use touch ID
            //UIAlertController
            //Check for his fingerprint is in the system
            KeychainWrapper.standard.set(self.passField.text!, forKey: k.PassKey)
            self.performSegue(withIdentifier: "login", sender: self)

        }
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let VC = segue.destination as? CollectionViewController else {return}
        VC.resourceType = .pokemon
    }
    
}

typealias TextFieldDelegate = LoginViewController
extension TextFieldDelegate: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === passField {
            textField.resignFirstResponder()
            
            guard emailField.Evaluate(.Email) else {
                Alert.Send(self, "Bad Email")
                return false
            }
            
            guard textField.Evaluate(.Password) else {
                Alert.Send(self, "Bad Password")
                return false
            }
            logInToFirebase()
           
            
        } else {
            
            guard textField.Evaluate(.Email) else {
                Alert.Send(self, "Bad Email")
                return false
            }
            textField.resignFirstResponder()
            passField.becomeFirstResponder()
        }
        return false
    }
}
















