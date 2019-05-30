//
//  Trip.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import Foundation
import CoreLocation
enum ModesOfTravel:String {
    case walking = "walking"
    case driving = "driving"
}
class Trip {
    var startAddressName:String?
    var endAddressName:String?
    var startCoordinates:CLLocation?
    var endCoordinates:CLLocation?
    var modesOfTravel:ModesOfTravel?
    var wayPoints:[CLLocation] = [CLLocation]()
    func isTripDataComplete() -> Bool {
        if wayPoints.count > 2 { /// There maybe cases where you may not get start and end address
            return true
        }
        guard startAddressName != nil && endAddressName != nil && startCoordinates != nil && endCoordinates != nil && modesOfTravel != nil else {
            return false
        }
        return true
    }
    func getTripInfoString() -> String? {
        if(isTripDataComplete()){
            var string = "Start: " + startAddressName! + "\nEnd: " + endAddressName! + "\n\(modesOfTravel!.rawValue)";
            let distance = startCoordinates!.distance(from: endCoordinates!);
            
            string += "\nDistance:\(String(format: "%.2f", distance/1000)) km"
            return string;
        }
        return nil;
    }
}
