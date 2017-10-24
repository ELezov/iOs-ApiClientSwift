//
//  Calculate.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 24.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

func getDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double ) -> Int{
    let R = 6371000.0
    let dLat = (lat1 - lat2) * M_PI / 180.0
    let dLon = (lon1 - lon2) * M_PI / 180.0
    let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * M_PI / 180.0) * cos(lat2 * M_PI / 180.0) * sin(dLon / 2) * sin(dLon / 2)
    let c = 2.0 * atan2(sqrt(a), sqrt(1 - a))
    let distance = R * c
    return Int(distance)
}

func getStringDistance(distance: Int) -> String{
    switch distance {
    case 0:
        return "..."
    case 1...999 :
        return String(distance) + " м"
    default:
        let dist = Double(distance) / 1000.0
        return String(Double(round(dist * 10) / 10)) + " км"
    }
}
