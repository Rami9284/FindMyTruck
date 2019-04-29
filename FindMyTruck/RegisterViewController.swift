//
//  RegisterViewController.swift
//  FindMyTruck
//
//  Created by Judith Ramirez on 4/8/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Parse
import Firebase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    ref = Database.database().reference()

    var userView: UIView!
    var truckView: UIView!
    //regular user
    @IBOutlet weak var Rusernamelabel: UILabel!
    @IBOutlet weak var RusernameText: UITextField!
    @IBOutlet weak var RpasswordLabel: UILabel!
    @IBOutlet weak var RpasswordText: UITextField!
    @IBOutlet weak var RtypeLabel: UILabel!
    @IBOutlet weak var RRetypeP: UITextField!
    @IBOutlet weak var RSignUp: UIButton!
    
    //truck user
    
    @IBOutlet weak var Trucknamelabel: UILabel!
    @IBOutlet weak var TtruckNametext: UITextField!
    @IBOutlet weak var Tusernamelabel: UILabel!
    @IBOutlet weak var TusernameText: UITextField!
    @IBOutlet weak var TpasswordText: UITextField!
    @IBOutlet weak var retypepassLabel: UILabel!
    @IBOutlet weak var Tretypepass: UITextField!
    @IBOutlet weak var truckSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userView = regularuser().view
//        truckView = truckOwner().view
        regularUser()
        // Do any additional setup after loading the view.
    }
    
    func regularUser(){
        Rusernamelabel.isHidden = false
        RusernameText.isHidden = false
        RpasswordLabel.isHidden = false
        RpasswordText.isHidden = false
        RtypeLabel.isHidden = false
        RRetypeP.isHidden = false
        RSignUp.isHidden = false
        
        Trucknamelabel.isHidden = true
        TtruckNametext.isHidden = true
        Tusernamelabel.isHidden = true
        TusernameText.isHidden = true
        TpasswordText.isHidden = true
        retypepassLabel.isHidden = true
        Tretypepass.isHidden = true
        truckSignUp.isHidden = true
    
    }
    
    @IBAction func regularSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = RusernameText.text
        user.password = RpasswordText.text
        
        if !(user.username?.isEmpty)! && !(user.password?.isEmpty)!{
            
            if (RpasswordText.text?.elementsEqual(RRetypeP.text!))!{
                print("inside")
                user.signUpInBackground{(success, error) in
                    if(success){
                        //self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        let alert = UIAlertController(title: "", message: "Successfully Signed Up", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert,animated: true)
                    } else {
                        let alert = UIAlertController(title: "", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
                        
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
    
    
    func truckOwner(){
        Rusernamelabel.isHidden = true
        RusernameText.isHidden = true
        //RpasswordLabel.isHidden = true
        RpasswordText.isHidden = true
        RtypeLabel.isHidden = true
        RRetypeP.isHidden = true
        RSignUp.isHidden = true
        
        Trucknamelabel.isHidden = false
        TtruckNametext.isHidden = false
        Tusernamelabel.isHidden = false
        TusernameText.isHidden = false
        TpasswordText.isHidden = false
        retypepassLabel.isHidden = false
        Tretypepass.isHidden = false
        truckSignUp.isHidden = false
        
    }
    
    @IBAction func onTruckSignUp(_ sender: Any) {
        let user = PFUser()
        
        user.username = TusernameText.text
        user.password = TpasswordText.text
        let rePass = Tretypepass.text
        let truckName = TtruckNametext.text
        

        
        //Checking if passwords match
        if (TpasswordText.text!.elementsEqual(rePass!) && !(rePass?.isEmpty)! && !(truckName?.isEmpty)! ){
            
            let truck = PFObject(className: "trucktable")
            truck["username"] = user.username
            truck["truckname"] = truckName
            //user["UserType"] = 0
            
            truck.saveInBackground()
            
            
            
            let u = PFObject(className: "User")
            u["username"] = user.username
            u["password"] = user.password
            u["UserType"] = 0
            
            u.saveInBackground()
//            user.signUpInBackground{(success, error) in
//                if (success){
//
//
//                    u.saveInBackground()
//
//                    print("User is added")
//
//                }else{
//                    let alert = UIAlertController(title: "", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                    self.present(alert,animated: true)
//                }
            }
//
//
//        }else{
//            let alert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        }
    }
    
    @IBAction func switchUserType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //regular user
            regularUser()
            break;
        case 1:
            //truck owner
            truckOwner()
            break;
        default:
            break
        }
    }
//
//
//
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
//    @IBAction func onSignUp(_ sender: Any) {
//        let user = PFUser()
//        user.username = usernamefield.text
//        user.password = passwordfield.text
//
//        if !(user.username?.isEmpty)! && !(user.password?.isEmpty)!{
//            print("before if")
//            if passwordfield.text == retypedPass.text{
//                print("inside")
//                user.signUpInBackground{(success, error) in
//                    if(success){
//                        //self.performSegue(withIdentifier: "loginSegue", sender: nil)
//                        let alert = UIAlertController(title: "it worked", message: "yes", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
//                        self.present(alert,animated: true)
//                    } else {
//                        let alert = UIAlertController(title: "", message: "\(error?.localizedDescription)", preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                        self.present(alert,animated: true)
//                    }
//                }
//            }
//        }else {
//            let alert = UIAlertController(title: "", message: "Fields can not be empty!", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        }
//
//

    //}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
