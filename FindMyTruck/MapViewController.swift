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
import AddressBook

struct mapTruck{
    var truckname: String
    var address: String
    var lat: NSString
    var long:NSString
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
    
    func mapItem() -> MKMapItem{
        let addressDictionary = [String(kABPersonAddressStreetKey) : subTitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(subTitle)"
        
        return mapItem
    }
}


class MapViewController: UIViewController{
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationServiceAuthenticationStatus()
    }
    
    func loadData(){
        db.collection("truckusers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    self.data[document.documentID] = document.data()
                    self.myTrucks.append(mapTruck(truckname: document["truckname"] as! String, address: document["address"] as! String, lat: document["lat"] as! NSString, long: document["long"] as! NSString))
                }
                self.loadPins()
            }
        }
    }
    
    func loadPins(){
        for t in myTrucks{
            var lat = t.lat.doubleValue
            var long = t.long.doubleValue
            var pin = customPin(pinTitle: t.truckname, pinSubTitle: t.address, location: CLLocationCoordinate2D(latitude: lat, longitude: long))
            mapView.addAnnotation(pin)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLocationServiceAuthenticationStatus(){
        locationManager.delegate = self
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) { mapView.showsUserLocation = true }
        else{ locationManager.requestWhenInUseAuthorization() }
    }
    
}

extension MapViewController : CLLocationManagerDelegate{
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

extension MapViewController: MKMapViewDelegate{
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if var annotation = annotation as? customPin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if var dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeueView.annotation = annotation
                view = dequeueView
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func getLongitude(for MapView: MKMapView) -> CLLocationDegrees{
        var long = MapView.centerCoordinate.longitude
        return long
    }
    
    func getLatitude(for MapView: MKMapView) -> CLLocationDegrees{
        var lat = mapView.centerCoordinate.latitude
        return lat
    }
    
    func getCenterLocation(for MapView: MKMapView) -> CLLocation {
        var latitude = mapView.centerCoordinate.latitude
        var longitude = MapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var location = view.annotation as! customPin
        var launchOption = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOption)
    }
}
