//
//  dataDecoding.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-05-15.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import Foundation
import CoreLocation

var distanceMatrix:[[Double]] = []

struct mapQueryData: Decodable {
    let results: [Results]
}

class Results: Decodable {
    init(_ name:String, _ geometry:Geometry, _ address:String) {
        self.name = name
        self.geometry = geometry
        self.formatted_address = address
    }
    
    let name:String
    let geometry:Geometry
    let formatted_address:String
}

struct Geometry: Decodable {
    let location:Location
}

struct Location: Decodable {
    let lat:Double
    let lng:Double
}
var resultsList:[Results] = []

var coordinatesList:[CLLocationCoordinate2D] = []

struct routeQueryData: Decodable {
    let routes:[Routes]
    let status: String
}

struct Routes: Decodable {
    let legs:[Legs]
}

struct Legs: Decodable {
    let steps:[Steps]
    let distance:Distance
}

struct Steps: Decodable {
    let start_location:Location
    let end_location:Location
}

struct Distance: Decodable {
    let text:String
    let value:Double
}
//var placeList: [String:Results]
