//
//  DirectionsViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 5/8/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mkMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var destCoordinates = CLLocationCoordinate2DMake(0.00,0.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mkMapView.delegate = self
        mkMapView.showsScale = true
        mkMapView.showsPointsOfInterest = true
        mkMapView.showsUserLocation = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let sourceCoordinates = locationManager.location?.coordinate
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error")
                }
                return
            }
            let route = response.routes[0]
            self.mkMapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.mkMapView.setRegion(MKCoordinateRegion(rekt), animated: true)
            
            })
        

        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
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
