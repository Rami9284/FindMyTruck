//
//  AddTruckViewController.swift
//  FindMyTruck
//
//  Created by Judith Ramirez on 5/6/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

struct truck{
    var truckname: String
    var description: String
    var address: String
    var time: String
    var lat: String
    var long:String
    var menu = [String]()
    
}

class AddTruckViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var item1: UITextField!
    @IBOutlet weak var item2: UITextField!
    @IBOutlet weak var item3: UITextField!
    @IBOutlet weak var item4: UITextField!
    @IBOutlet weak var item5: UITextField!
    @IBOutlet weak var item6: UITextField!
    
    
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
    
    let pickerData = [["1", "2","3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],[":"],["00","01", "02","03", "04", "05", "06", "07", "08", "09", "10", "11", "12","13", "14","15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26","27", "28", "29", "30", "31", "32", "33", "34", "35", "36","37", "38","39", "40", "41", "42", "43", "44", "45", "46", "47", "48","49","50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],["AM","PM"]]
    
    var starthour: String = "1"
    var startminutes: String = "00"
    var startampm:String = ""
    
    var endhour: String = "1"
    var endminutes: String = "00"
    var endampm:String = ""
    var timeString: String = ""
    var lat = ""
    var long = ""
    
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeStartField.dataSource = self
        self.timeStartField.delegate = self
        self.timeEndField.dataSource = self
        self.timeEndField.delegate = self
        
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView)->Int{
        return pickerData.count
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
    return pickerData[component].count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String? {
        
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //end
        if pickerView.tag == 1{
            if(component == 0){
                endhour = pickerData[component][row]
            }else if (component == 2){
                endminutes = pickerData[component][row]
            }else if (component == 3){
                endampm = pickerData[component][row]
            }
        //start
        }else if pickerView.tag == 0{
            if(component == 0){
                starthour = pickerData[component][row]
            }else if (component == 2){
                startminutes = pickerData[component][row]
            }else if (component == 3){
                startampm = pickerData[component][row]
            }
        }
        
        timeString = "\(starthour):\(startminutes) \(startampm) - \(endhour):\(endminutes) \(endampm)"
        
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onAdd(_ sender: Any) {
        
        var data = [String]()
        let geocoder = CLGeocoder()
        let address = addressField.text as! String
        
        geocoder.geocodeAddressString(addressField.text as! String, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.lat = String(format:"%.4f", coordinates.latitude)
                print("lat: " + self.lat)
                self.long = String(format:"%.4f", coordinates.longitude)
                print("long: " + self.long)
                self.getCoord(lati: self.lat, longi: self.long)
            }
        })
    
//        while(lat == ""){
//
//        }
        //getCoord()
        print("Check 1 2 3")
        
    }
    
    func getCoord(lati: String, longi:String ) {

        if(!truckNameField.text!.isEmpty || !addressField.text!.isEmpty){
            let user = Auth.auth().currentUser
            
            self.db.collection("truckusers").document((user?.uid)!).setData([
                
                "truckname": truckNameField.text as! String,
                "menu": [item1.text,item2.text,item3.text,item4.text,item5.text,item6.text],
                "lat": lati,// get lat and long from address??
                "long": longi,
                "description": descriptionField.text as! String,
                "address": addressField.text as! String,
                "time": timeString
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }else {
            let alert = UIAlertController(title: "", message: "Truck name and address can not be empty!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert,animated: true)
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
