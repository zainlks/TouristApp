//
//  distanceGraph.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-05-17.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import Foundation
import CoreLocation

struct distanceGraph {
    init(_ inStruct:Results) {
        self.mainStruct = inStruct
    }
    
    var mainStruct:Results
    
    func calculateDistances() {
        
    }
    
    var distances:[[AnyObject]] = []
}

var distanceGraphList:[distanceGraph] = []
