//
//  AddTruckViewController.swift
//  FindMyTruck
//
//  Created by Judith Ramirez on 5/6/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit

class AddTruckViewController: UIViewController {

    @IBOutlet weak var trucknameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    
    @IBOutlet weak var truckNameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var timeStartField: UIPickerView!
    @IBOutlet weak var timeEndField: UIPickerView!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var menuField: UITextView! // Could we create kind of a like "add item" type of entry? ' ---> maybe create and hide labels and show when they press the button "add item" or so. 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onAdd(_ sender: Any) {
        
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
