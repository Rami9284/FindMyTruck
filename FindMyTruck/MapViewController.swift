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
import Parse
import FirebaseAuth
import FirebaseFirestore

struct mapTruck{
    var truckname: String
    var address: String
    var lat: String
    var long:String
    
    init(truckname:String, address:String, lat:String, long:String){
        self.truckname = truckname
        self.address = address
        self.lat = lat
        self.long = long
    }
}

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D){
        self.title = pinTitle
        self.subTitle = pinSubTitle
        self.coordinate = location
        
        super.init()
    }
    
    var subtitle: String? {
        return subTitle
    }
}


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    @IBOutlet weak var onAddbtn: UIButton!
    @IBOutlet weak var onLogoutBtn: UIBarButtonItem!
    @IBOutlet weak var onloginBtn: UIBarButtonItem!
    
    var db:Firestore!
    var data=[String : Dictionary<String, Any>]()
    var myTrucks = [mapTruck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
        db = Firestore.firestore()
        
        if Auth.auth().currentUser != nil {
            onloginBtn.isEnabled = false
            onLogoutBtn.isEnabled = true
            onAddbtn.isHidden = false
        } else {
            onloginBtn.isEnabled = true
            onLogoutBtn.isEnabled = false
            onAddbtn.isHidden = true
        }
        
        loadData()

    }
    
    func loadData(){
        db.collection("truckusers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    self.data[document.documentID] = document.data()
                    self.myTrucks.append(mapTruck(truckname: document["truckname"] as! String, address: document["address"] as! String, lat: document["lat"] as! String, long: document["long"] as! String))
                }
                
            }
        }
        
        
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    @IBAction func onLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            onloginBtn.isEnabled = true
            onLogoutBtn.isEnabled = false
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
            startTrackUserLocation()
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
    
    //Helper function for the case of AuthorizeWhenInUse is triggered
    func startTrackUserLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getLongitude(for MapView: MKMapView) -> CLLocationDegrees{
        let long = MapView.centerCoordinate.longitude
        return long
    }
    
    func getLatitude(for MapView: MKMapView) -> CLLocationDegrees{
        let lat = mapView.centerCoordinate.latitude
        return lat
    }
    
    func getCenterLocation(for MapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = MapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //Guard against no location in case location.last is nil
//        guard let location = locations.last else{return}
//        //Creating a center from user's last known location
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        //Creating a region with user's last known location as it's center
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
//    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Update when the user changes the authorization
        checkLocationAuthorization()
    }
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let center = getCenterLocation(for: mapView)
//        let geoCoder = CLGeocoder()
//
//        guard center.distance(from: previousLocation!) > 50 else{ return }
//        previousLocation = center
//
//        geoCoder.reverseGeocodeLocation(center) {[weak self] (placemarks, error) in
//            guard let self = self else {return}
//
//            if let _ = error {
//                //TODO: Show alert informing the user
//                return
//            }
//
//            guard let placemark = placemarks?.first else{
//                //TODO: Show alert informing the user
//                return
//            }
//
//            let streetNumber = placemark.subThoroughfare
//            let streetName = placemark.thoroughfare
//
//            DispatchQueue.main.sync {
//                //self.addressLabel.text = "\(streetNumber) \(streetName)"
//            }
//
//        }
//    }
}
