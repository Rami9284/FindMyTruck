//
//  ListDetailsViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 5/6/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import MapKit

class ListDetailsViewController: UIViewController {
    
    var myTruck: Truck!

    @IBOutlet weak var truckName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var detailsDescription: UILabel!
    @IBOutlet weak var menu: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsImage.image = UIImage(named: "tacos")
        
        truckName.text = myTruck.truckname
        address.text = myTruck.address
        detailsDescription.text = myTruck.description
        
        menu.text = ""
        for each in myTruck.menu{
            menu.text = (menu.text ?? "") + each + "\n"
        }
        address.sizeToFit()
        detailsDescription.sizeToFit()
        menu.sizeToFit()
        menu.center.x = self.view.center.x
        
                
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let long = myTruck.long.doubleValue
        let lat = myTruck.lat.doubleValue
        
        let destCoord = CLLocationCoordinate2DMake(long, lat)
        let directionsViewController = segue.destination as! DirectionsViewController
        directionsViewController.destCoordinates = destCoord
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
