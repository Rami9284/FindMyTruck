//
//  regularuser.swift
//  FindMyTruck
//
//  Created by Judith Ramirez on 4/16/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Parse

class regularuser: UIViewController {

    @IBOutlet weak var retypedPass: UITextField!
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var usernamefield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
                user.username = usernamefield.text
                user.password = passwordfield.text
        
                if !(user.username?.isEmpty)! && !(user.password?.isEmpty)!{
                    if passwordfield.text == retypedPass.text{
                        user.signUpInBackground{(success, error) in
                            if(success){
                                //self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                let alert = UIAlertController(title: "it worked", message: "yes", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
                                self.present(alert,animated: true)
                            } else {
                                let alert = UIAlertController(title: "", message: "\(error?.localizedDescription)", preferredStyle: .alert)
        
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
                                self.present(alert,animated: true)
                            }
                        }
                    }
                }else {
                    let alert = UIAlertController(title: "", message: "Fields can not be empty!", preferredStyle: .alert)
        
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
