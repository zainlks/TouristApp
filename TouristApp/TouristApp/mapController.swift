//
//  mapController.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-05-15.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps
import CoreLocation

var placesClient: GMSPlacesClient!
let locationManager = CLLocationManager()


struct mapHandle {
//    
//    init(_ mapView:GMSMapView) {
//        self.mainView = mapView
//    }
    func performRequest() {
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=top%2010%20things%20to%20do%20in%2038%20fogerty%20street&key=AIzaSyA2Yaa5DnJAwgSzgAr3ITT5yuyZag4v57o") {
            
            
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler:  { (data, response, error) in
                   if error != nil {
                       print(error!)
                       return
                   }
                   
                   if let incomingData = data {
                       let dataString = String(data: incomingData, encoding: .utf8)
                       self.parseJson(incomingData)
                   }
               })
            
            task.resume()
            
            
        }
        
    }
    
    func parseJson(_ inData:Data) {
       let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(mapQueryData.self, from: inData)
            print(decodedData.results.count)
            
            
            
            
            
            
        } catch {
            
        }
    }
    
    
    func getCurLocation() {
         placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
           if let error = error {
             print("Current Place error: \(error.localizedDescription)")
             return
           }

    //         self.locationTextField.text = "No current place"
    //         self.locationTextField.text = ""

           if let placeLikelihoodList = placeLikelihoodList {
             let place = placeLikelihoodList.likelihoods.first?.place
             if let place = place {
    //             self.locationTextField.text = place.name
    //             self.locationTextField.text = place.formattedAddress?.components(separatedBy: ", ")
    //             .joined(separator: "\n")
                let curLocation = GMSCameraPosition(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
                let newLoc = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
                self.mainView!.camera = curLocation
                self.mainView!.animate(toLocation: newLoc)
                 let marker = GMSMarker()
                 marker.position = CLLocationCoordinate2D(latitude:place.coordinate.latitude, longitude: place.coordinate.longitude)
                marker.title = place.formattedAddress
                marker.isDraggable = true
                marker.map = self.mainView!

             }
           }
         })
     }
    var mainView:GMSMapView?
}





var mapClass = mapHandle()

