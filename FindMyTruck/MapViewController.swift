//
//  MapViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 4/6/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //Once user's location is determined the map will zoom into location with a span of 10000 meters
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            //Setup our location manager
            setupLocationManager()
            checkLocationAuthorization()
        }else{
            //Show alert letting the user know they havve to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        //Only able to get user's location when using the app
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        //Prompt user to use their location and the user chooses "Do Not Allow"
        case .denied:
            //Show alert instructing users how to turn on permissions
            break
        //User's haven't chosen "Allow" or "Do Not Allow"
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        //Allows the app to get user's location even while being in the background
        case .authorizedAlways:
            break
        //Doesn't allow location to be used by the app due to parental control or other circumstances
        case .restricted:
            //Show alert instructing users how to turn on permissions
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Guard against no location in case location.last is nil
        guard let location = locations.last else{return}
        //Creating a center from user's last known location
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //Creating a region with user's last known location as it's center
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Update when the user changes the authorization
        checkLocationAuthorization()
    }
}
