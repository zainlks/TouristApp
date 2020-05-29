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
    
    func requestRoute(_ startAddress:String?, _ endAddress:String?) -> Double {
        var requestedDistance:Double = 0
        let startString:String? = startAddress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let endString:String? = endAddress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var finalString:String? = "https://maps.googleapis.com/maps/api/directions/json?origin=" + startString! + "&destination="
        finalString = finalString! + endString! + "&key=AIzaSyA2Yaa5DnJAwgSzgAr3ITT5yuyZag4v57o"
        
//        print(finalString!)
        let url = URL(string: finalString!)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let incomingData = data {
//                let dataString = String(data: incomingData, encoding: .utf8)
//                print(dataString)
                requestedDistance = self.returnDistance(incomingData)
                
            }
        })
            task.resume()
            return requestedDistance
    }
    
    func returnDistance(_ inData:Data) -> Double{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(routeQueryData.self, from: inData)
//            print(decodedData.routes[0])
            if(decodedData.status != "NOT_FOUND" && decodedData.status != "OVER_QUERY_LIMIT") {
                print(decodedData.status)
                print(decodedData.routes[0].legs[0].distance.value)
                return(decodedData.routes[0].legs[0].distance.value)
            }
            else {
                print(decodedData.status)
                return 0
            }
        } catch {
            print("Json Parsing Error in route request handling")
            return 0;
        }
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
        } catch {
            print("errorlksjd")
        }
    }
}

var routeHandler = routeHandle()
