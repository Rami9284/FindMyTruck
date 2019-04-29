//
//  LoginViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 4/6/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func onLogIn(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!){
            (user,error) in
            
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else {
                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert,animated: true)
            }
        }
    }
    
    
}
