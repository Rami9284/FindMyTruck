//
//  RegisterViewController.swift
//  FindMyTruck
//
//  Created by Judith Ramirez on 4/8/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Parse
import FirebaseDatabase
import Firebase

class RegisterViewController: UIViewController {
    
    var ref:DatabaseReference!
    
    let db = Firestore.firestore()

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
    
    @IBOutlet weak var tacoimg: UIImageView!
    @IBOutlet weak var truckimg: UIImageView!
    @IBOutlet weak var poofimg: UIImageView!
    
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
        ref = Database.database().reference()
        regularUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSwitchType(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
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
    
    func regularUser(){
        Rusernamelabel.isHidden = false
        RusernameText.isHidden = false
        RpasswordLabel.isHidden = false
        RpasswordText.isHidden = false
        RtypeLabel.isHidden = false
        RRetypeP.isHidden = false
        RSignUp.isHidden = false
        tacoimg.isHidden = false
        
        Trucknamelabel.isHidden = true
        TtruckNametext.isHidden = true
        Tusernamelabel.isHidden = true
        TusernameText.isHidden = true
        TpasswordText.isHidden = true
        retypepassLabel.isHidden = true
        Tretypepass.isHidden = true
        truckSignUp.isHidden = true
        truckimg.isHidden = true
        poofimg.isHidden = true
    
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let email = RusernameText.text
        let password = RpasswordText.text
        
        if !(email?.isEmpty)! && !(password?.isEmpty)!{
            
            if (RpasswordText.text?.elementsEqual(RRetypeP.text!))!{
                
                Auth.auth().createUser(withEmail: email!, password: password!)
                { authResult, error in
                    
                    if((error) != nil){
                        let alert = UIAlertController(title: "", message: "\(error!.localizedDescription )", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(alert,animated: true)
                    }else if (authResult != nil){
                        let user = Auth.auth().currentUser
                        let changeRequest = user?.createProfileChangeRequest()
                        changeRequest?.displayName = "0"
                        
                       
                        
                        self.db.collection("users").document(email!).setData([
                            "favorites": ["",""]
                        ])
                        //self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        self.dismiss(animated: true, completion: nil)
                        
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
        tacoimg.isHidden = true
        
        Trucknamelabel.isHidden = false
        TtruckNametext.isHidden = false
        Tusernamelabel.isHidden = false
        TusernameText.isHidden = false
        TpasswordText.isHidden = false
        retypepassLabel.isHidden = false
        Tretypepass.isHidden = false
        truckSignUp.isHidden = false
        truckimg.isHidden = false
        poofimg.isHidden = false
    }
    
    @IBAction func onTruckSignUp(_ sender: Any) {
        
        let email = TusernameText.text
        let password = TpasswordText.text
        let rePass = Tretypepass.text
        let truckName = TtruckNametext.text
        
        //Checking if passwords match
        if (TpasswordText.text!.elementsEqual(rePass!) && !(rePass?.isEmpty)! && !(truckName?.isEmpty)! ){
            
            Auth.auth().createUser(withEmail: email!, password: password!){ authResult, error in
                
                if((error) != nil){
                    
                    let alert = UIAlertController(title: "", message: "\(error!.localizedDescription )", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert,animated: true)
                    
                }else if ((authResult) != nil){
                    
                    let user = Auth.auth().currentUser
                     let changeRequest = user?.createProfileChangeRequest()
                     changeRequest?.displayName = "1"
                    changeRequest?.commitChanges{
                        (error) in print("could not update info")
                    }
                    
                    //add entry with truck table
                    self.db.collection("truckusers").document((user?.uid)!).setData([
                        "username": email,
                        "truckname": truckName,
                        "menu": ["","",""],
                        "lat":"",
                        "long": "",
                        "time":"",
                        "description": "",
                        "address": "",
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            UIView.animate(withDuration: 0.8, animations: {
                                self.truckimg.center.x += 300
                                self.poofimg.center.x += 300
                                
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.dismiss(animated: true, completion: nil)
                            })
                            //self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                    
                    
                    //self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
        }
        }
    }
        
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    

}
