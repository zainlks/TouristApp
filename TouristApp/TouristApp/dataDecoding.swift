//
//  dataDecoding.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-05-15.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import Foundation


struct mapQueryData: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    init(_ name:String, _ geometry:Geometry) {
        self.name = name
        self.geometry = geometry
    }
    
    let name:String
    let geometry:Geometry
}

struct Geometry: Decodable {
    let location:Location
}

struct Location: Decodable {
    let lat:Double
    let lng:Double
}
var resultsList:[Results] = []
//var placeList: [String:Results]
