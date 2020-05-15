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
    init(_ name:String) {
        self.name = name
    }
    let name:String
}

//var placeList: [String:Results]
