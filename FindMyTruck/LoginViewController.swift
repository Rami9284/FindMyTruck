//
//  LoginViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 4/6/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
//import Parse
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func onLogIn(_ sender: Any) {
        let email = usernameTextField.text
        let password = passwordTextField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if user != nil {
                
                self!.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }else {
                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self!.present(alert,animated: true)
            }
            
        }
        
//        PFUser.logInWithUsername(inBackground: username!, password: password!){
//            (user,error) in
//
//            if user != nil {
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            }else {
//                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                self.present(alert,animated: true)
//            }
//        }
    }
    
    
}
