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
                let alert = UIAlertController(title: "it worked", message: "yes", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
                self.present(alert,animated: true)
            }
        }
//
//        PFUser.logInWithUsername(inBackground: username!, password: password!){
//            (user, error) in
//
//            if user != nil{
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            } else {
//                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                self.present(alert,animated: true)
//            }
//        }
    }
    
    
    
    
    //    @IBAction func onSignIn(_ sender: Any) {
//        let username = usernameField.text
//        let password = passwordfield.text
//
//        PFUser.logInWithUsername(inBackground: username!, password: password!){
//            (user, error) in
//
//            if user != nil{
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            } else {
//                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription)", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                self.present(alert,animated: true)
//                //self.dismiss(animated: true, completion: nil)
//                //print("Error: \(error?.localizedDescription)")
//            }
//        }
//    }
//
//    @IBAction func onSignUp(_ sender: Any) {
//        let user = PFUser()
//        user.username = usernameField.text
//        user.password = passwordfield.text
//
//        user.signUpInBackground{(success, error) in
//            if(success){
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            } else {
//                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription)", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                self.present(alert,animated: true)
//            }
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
