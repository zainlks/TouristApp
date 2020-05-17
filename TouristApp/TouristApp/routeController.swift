//
//  routeController.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-05-15.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps
import GooglePlaces

class routeHandle {
    
    func requestRoute(_ startAddress:String?, _ endAddress:String?) {
        var startString:String? = startAddress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var endString:String? = endAddress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var finalString:String? = "https://maps.googleapis.com/maps/api/directions/json?origin=" + startString! + "&destination="
        finalString = finalString! + endString! + "&key=AIzaSyA2Yaa5DnJAwgSzgAr3ITT5yuyZag4v57o"
        
        print(finalString)
        let url = URL(string: finalString!)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let incomingData = data {
                let dataString = String(data: incomingData, encoding: .utf8)
//                print(dataString)
                self.parseJson(incomingData)
                
            }
        })
            task.resume()
    
    }
    
    func parseJson(_ inData:Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(routeQueryData.self, from: inData)
            print(decodedData.routes[0])
            for i in 0...decodedData.routes[0].legs[0].steps.count-1 {
//                    print(decodedData.routes[0].legs[0].steps[i].start_location.lat)
                mapClass.path.add(CLLocationCoordinate2DMake(decodedData.routes[0].legs[0].steps[i].start_location.lat,decodedData.routes[0].legs[0].steps[i].start_location.lng))
                mapClass.path.add(CLLocationCoordinate2DMake(decodedData.routes[0].legs[0].steps[i].end_location.lat,decodedData.routes[0].legs[0].steps[i].end_location.lng))
//                    print("done")
            }
            mapClass.dispatchGroup.leave()
        } catch {
            print("errorlksjd")
        }
    }
}

var routeHandler = routeHandle()
