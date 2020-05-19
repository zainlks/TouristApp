//
//  ViewController.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-03-23.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapFrame = CGRect(x: self.view.bounds.midX-(100/2), y: self.view.bounds.midY, width: 100, height: 100)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapClass.mainView = mapView
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
              mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
              NSLog("Unable to find mapStyle.json")
            }
          } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
          }
        
        self.view.addSubview(mapView)
        self.view.sendSubviewToBack(mapView)

        // Creates a marker in the center of the map.
        locationTextField.delegate = self
        locationTextField.attributedPlaceholder = NSAttributedString(string: locationTextField.placeholder!,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        mapClass.getCurLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "citySelectSegue", sender: self)
        locationTextField.endEditing(true)
        if let tempVar = locationTextField.text {
            print(tempVar)
        }
        else {print("nothing in text field")}
//        mapClass.performRequest(locationTextField.text)
    }
    
    @IBAction func curLocButtonPressed(_ sender: UIButton) {
        mapClass.performRequest(mapClass.getCurLocation())
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        locationTextField.text = " "
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        locationTextField.endEditing(true)
        mapClass.performRequest(locationTextField.text)
    }


}

