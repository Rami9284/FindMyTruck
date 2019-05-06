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

struct Truck {
    var username: String
    var truckname: String
    var description: String
    var address: String
    var lat: String
    var long:String
    var menu = [String]()
    
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var db:Firestore!
    
    var myTrucks = [Truck]()
    var id = [String]()
    var data=[String : Dictionary<String, Any>]()
    var cellNum = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
    func loadData(){
        db.collection("truckusers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    self.data[document.documentID] = document.data()
                    self.myTrucks.append(Truck(username: document["username"] as! String,truckname: document["truckname"] as! String, description: document["description"] as! String,address: document["address"] as! String,lat: document["lat"] as! String,long: document["long"] as! String, menu: document["menu"] as! [String]))
                    self.cellNum += 1
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        

        print("foo")
        print (myTrucks)

        cell.cellTruckname.text = myTrucks[indexPath.row].truckname
        cell.celladdress.text = myTrucks[indexPath.row].description
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
