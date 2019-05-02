//
//  ListViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 4/28/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:DatabaseReference!
    
    lazy var db = Firestore.firestore()
    
    var d = [NSObject]()
    var data=[String : Any]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //FirebaseApp.configure()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        
        db.collection("truckusers").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.data = document.data()
                    
                }
            }
        }
        //let jsonData = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions = [])
    
    
        cell.cellTruckname.text = data["truckname"] as? String
        cell.celladdress.text = data["address"] as? String
        cell.cellDistance.text = "2 miles away"
        
        return cell
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
