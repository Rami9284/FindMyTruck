//
//  truckOwner.swift
//  FindMyTruck
//
//  Created by Judith Ramirez on 4/16/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Parse

class truckOwner: UIViewController {

    @IBOutlet weak var truckName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignup(_ sender: Any) {
        print ("here")
        let user = PFUser()
        
        let usern = username.text
        let pass = password.text
        let rePass = rePassword.text
    
        //Checks if all fields are filled out
        if usern == "" || pass == "" || rePass == ""{
            let alert = UIAlertController(title: "Error", message: "Fields must be filled out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        
        //Checking if passwords match
        if (pass?.elementsEqual(rePass!))!{
            //Success- create user
            //let truckUser = PFObject(className: "User")
            user["username"] = usern
            user["password"] = pass
            user["UserType"] = 0
            
            user.signUpInBackground{(success, error) in
                if (success){
                    print("User is added")
                }else{
                    print("Error creating User")
                }
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
