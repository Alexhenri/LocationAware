//
//  ViewController.swift
//  LocationAware
//
//  Created by Alexandre Henrique Silva on 19/03/18.
//  Copyright © 2018 Alexhenri. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var latitudeResultLabel: UILabel!
    @IBOutlet weak var longitudeResultLabel: UILabel!
    @IBOutlet weak var courseResultLabel: UILabel!
    @IBOutlet weak var speedResultLabel: UILabel!
    @IBOutlet weak var altitudeResultLabel: UILabel!
    @IBOutlet weak var thorougFareLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var subAdminAreaLabel: UILabel!
    @IBOutlet weak var subLocalityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                print("Error \(#line): Error getting placemark.")
                return
            }
            guard let placemark = placemarks?[0] else {
                print("Error \(#line): Error getting placemark from placemarks.")
                return
            }
            print("Locations (\(userLocation)))")
            print("Placemark (\(placemark))")
            
            self.latitudeResultLabel.text   = String(userLocation.coordinate.latitude)
            self.longitudeResultLabel.text  = String(userLocation.coordinate.longitude)
            self.altitudeResultLabel.text   = String(userLocation.altitude)
            self.speedResultLabel.text      = String(userLocation.speed)
            self.courseResultLabel.text     = String(userLocation.course)
            
            if let thorough = placemark.thoroughfare {
                    self.thorougFareLabel.text = "\(thorough)"
            }
            
            if let subThorough = placemark.subThoroughfare {
                self.thorougFareLabel.text = self.thorougFareLabel.text! + "\(subThorough)"
            }
            
            if let postalCode = placemark.postalCode  {
                self.postalCodeLabel.text = postalCode
            }
            
            if let subAdmin = placemark.subAdministrativeArea  {
                self.subAdminAreaLabel.text = subAdmin
            }
            
            if let subLocality = placemark.subLocality  {
                self.subLocalityLabel.text = subLocality
            }
            
            if let country = placemark.country  {
                self.countryLabel.text = country
            }
        }
    }

}

