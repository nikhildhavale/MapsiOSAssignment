//
//  LocationManager.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 30/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import Foundation
import CoreLocation
protocol TripDataSetDelegate:class {
    func startAddress(startAddress:String)
    func endAddress(endAddress:String)
}
class LocationManager:NSObject,CLLocationManagerDelegate {
    static let shared = LocationManager()
    var manager:CLLocationManager
    var trip = Trip()
    var trackingStarted = false
    weak var tripDataSetDelegate:TripDataSetDelegate?
    private override init(){
        manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
    }

    func startTracking(modeOfTravel:ModesOfTravel){
        trip.modesOfTravel = modeOfTravel
        if modeOfTravel == .driving {
            manager.distanceFilter = 1000
        }
        else {
            manager.distanceFilter = 10
        }
        trackingStarted = true
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    func stopTracking(){
        trackingStarted = false
        if let lastLocation = self.trip.wayPoints.last {
            trip.endCoordinates = lastLocation
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placeMarkArray, error) in
                if let placeMarkItem = placeMarkArray?.first {
                    self.trip.endAddressName = placeMarkItem.description.components(separatedBy: "@").first
                    self.tripDataSetDelegate?.endAddress(endAddress: self.trip.endAddressName!)
                }
                else {
                    self.tripDataSetDelegate?.endAddress(endAddress: "\(lastLocation)")

                }
            })
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if trip.startCoordinates == nil {
                trip.startCoordinates = location
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarkArray, error) in
                        if let placeMarkItem = placeMarkArray?.first {
                            self.trip.startAddressName = placeMarkItem.description.components(separatedBy: "@").first
                            self.tripDataSetDelegate?.startAddress(startAddress: self.trip.startAddressName!)

                        }
                        else {
                            self.tripDataSetDelegate?.startAddress(startAddress: "\(location)")
                    }
                    })
            }
            else {
                
                trip.wayPoints.append(location)
            }
        }
    }
}
