//
//  MapViewController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var trip = Trip()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if trip.isTripDataComplete() {
            let startLocation = trip.startCoordinates!.coordinate
            let endLocation = trip.endCoordinates!.coordinate
            let startPoint = MKPointAnnotation()
            startPoint.title = trip.startAddressName
            startPoint.coordinate = startLocation
            let endPoint = MKPointAnnotation()
            endPoint.title = trip.endAddressName
            endPoint.coordinate = endLocation
            self.mapView.showAnnotations([startPoint,endPoint], animated: true)
            
           
         
          
           
            if trip.wayPoints.count > 2 {
                var index = 0
                while index < trip.wayPoints.count
                {
                    let startLocation = trip.wayPoints[index]
                    if index + 1 < trip.wayPoints.count {
                        let endLocation = trip.wayPoints[index + 1]
                        setDirectionRequest(startLocation: startLocation.coordinate, endLocation: endLocation.coordinate)
                    }
                    index += 2
                }
            }
            else {
              setDirectionRequest(startLocation: startLocation, endLocation: endLocation)
            }
         
            
        }

    }
    func setDirectionRequest(startLocation:CLLocationCoordinate2D,endLocation:CLLocationCoordinate2D){
        let sourcePlaceMark = MKPlacemark(coordinate: startLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: endLocation)
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        let direction = MKDirections(request: directionRequest)
        direction.calculate(completionHandler: {(response,error) in
            guard let response = response else {
                return
            }
            if let route = response.routes.first {
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            }
        })
        if trip.modesOfTravel == ModesOfTravel.driving{
            directionRequest.transportType = .automobile
            
        }
        else {
            directionRequest.transportType = .walking
            
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.black
        if trip.isTripDataComplete() {
            if trip.modesOfTravel == ModesOfTravel.walking {
                render.lineDashPattern = [2, 5]
            }
        }
        
        return render
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
