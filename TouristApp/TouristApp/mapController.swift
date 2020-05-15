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


class mapHandle {
//    
//    init(_ mapView:GMSMapView) {
//        self.mainView = mapView
//    }
    func performRequest() {
        var tempString:String? = curLocationAdress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=top%2010%20things%20to%20do%20near%20" + tempString! + "&key=AIzaSyA2Yaa5DnJAwgSzgAr3ITT5yuyZag4v57o") {
            
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
            for i in 0...decodedData.results.count-1 {
                resultsList.append(Results(decodedData.results[i].name,decodedData.results[i].geometry))
            }
            print(resultsList[0].geometry.location.lat)
            updateMapData()
            
        } catch {
            print("eroor Occured")
        }
    }
    
    func updateMapData() {
        print(resultsList.count)
        DispatchQueue.main.async {
            for i in 0...resultsList.count-1 {
                let marker = GMSMarker()
                let newMarkerLoc = CLLocationCoordinate2DMake(resultsList[i].geometry.location.lat, resultsList[i].geometry.location.lng)
                marker.position = newMarkerLoc
                marker.title = resultsList[i].name
                marker.map = self.mainView!
            }
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
                self.curLocationAdress = place.formattedAddress
                print(self.curLocationAdress!)
                marker.title = place.formattedAddress
                marker.isDraggable = true
                marker.map = self.mainView!

             }
           }
         })
     }
    var mainView:GMSMapView?
    var curLocationAdress:String?
}





var mapClass = mapHandle()

