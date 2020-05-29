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
    func performRequest(_ userPlace:String?) {
        
        let tempString:String? = userPlace?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=top%2010%20things%20to%20do%20near%20" + tempString! + "&key=AIzaSyA2Yaa5DnJAwgSzgAr3ITT5yuyZag4v57o") {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler:  { (data, response, error) in
                   if error != nil {
                       print(error!)
                       return
                   }
                   
                   if let incomingData = data {
//                       let dataString = String(data: incomingData, encoding: .utf8)
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
            resultsList = []
            coordinatesList = []
            if(decodedData.results.count>2) // Checking if google yielded any actual results
            {
                for i in 0...decodedData.results.count-1 {
                    coordinatesList.append(CLLocationCoordinate2DMake(decodedData.results[i].geometry.location.lat, decodedData.results[i].geometry.location.lng))
                    resultsList.append(Results(decodedData.results[i].name,decodedData.results[i].geometry, decodedData.results[i].formatted_address))
    //                path.add(CLLocationCoordinate2DMake(decodedData.results[i].geometry.location.lat, decodedData.results[i].geometry.location.lng))
                }
                for x in 0...resultsList.count-1 {
                    var tempDistance:[Double] = []
                    for w in 0...resultsList.count-1 {
                        if(resultsList[x].formatted_address != resultsList[w].formatted_address) {
                            let tempVar = routeHandler.requestRoute(resultsList[x].formatted_address, resultsList[w].formatted_address)
                            tempDistance.append(tempVar)
                            
                        }
                        else{
                            print("Starting and Ending Address the same, appending 0 -> mapContoller.swift")
                            tempDistance.append(0.0)
                        }
                    }
                    distanceMatrix.append(tempDistance)
                }
//                print(resultsList[0].geometry.location.lat)
                print(distanceMatrix)
                self.updateMapData()
                
                
            }
            else {
                print("no results")
            }
            
        } catch {
            print("eroor Occured")
        }
    }
    
    func updateMapData() {
        print(resultsList.count)
        DispatchQueue.main.async {
            self.mainView!.clear()
            var bounds = GMSCoordinateBounds.init()
            for i in 0...resultsList.count-1 {
                let marker = GMSMarker()
                let newMarkerLoc = CLLocationCoordinate2DMake(resultsList[i].geometry.location.lat, resultsList[i].geometry.location.lng)
                marker.position = newMarkerLoc
                marker.title = resultsList[i].name
                marker.map = self.mainView!
                bounds = bounds.includingCoordinate(newMarkerLoc)
                if(i != 0 && i != resultsList.count-1) {
//                    dispatchGroup.enter()
//                    routeHandler.requestRoute(resultsList[i].formatted_address, resultsList[i+1].formatted_address)
                    mapClass.path.add(CLLocationCoordinate2DMake(resultsList[i].geometry.location.lat,resultsList[i].geometry.location.lng))
                }
            }
//            routeHandler.requestRoute(resultsList[0].formatted_address, resultsList[1].formatted_address)
//            let newLoc = GMSCameraPosition(latitude: resultsList[0].geometry.location.lat, longitude: resultsList[0].geometry.location.lng, zoom: 14.0)
            let newLoc = self.mainView!.camera(for: bounds, insets: UIEdgeInsets())
            self.mainView!.camera = newLoc!
            let connectingLine = GMSPolyline(path: self.path)
            connectingLine.strokeWidth = 4.0
            connectingLine.geodesic = true
            connectingLine.map = self.mainView!
        }
    }
    
    func getCurLocation() -> String?{
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
        return curLocationAdress
     }
    
    
    var mainView:GMSMapView?
    var curLocationAdress:String?
    let path = GMSMutablePath()
    let dispatchGroup = DispatchGroup()
}





var mapClass = mapHandle()

