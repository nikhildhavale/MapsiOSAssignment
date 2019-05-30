//
//  AddTripViewController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit
import CoreLocation
protocol AutoCompleteDataDelegate:class {
    func sendAutoCompleteData(placemark:[CLPlacemark])
}
class AddTripViewController: UIViewController {
    weak var addTripDelegate:AddTripDelegate?
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var autoCompleteTableViewContainer: UIView!
    var topActualConstraint:NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        topConstraint.isActive = false
        autoCompleteTableViewContainer.layer.borderColor = UIColor.gray.cgColor
        autoCompleteTableViewContainer.layer.borderWidth = 1.0
    }
    override func viewWillAppear(_ animated: Bool) {
        if let childController = children.first as? AddTripTableViewController , let autoCompleteController = children.last as? AutoCompleteTableViewController  {
            childController.delegate = autoCompleteController
        }
    }
    @IBAction func doneButtonClicked(_ sender: Any) {
        if let childController = children.first as? AddTripTableViewController {
            if(childController.trip.isTripDataComplete() && childController.endAddressCalled){
                addTripDelegate?.addTrip(trip: childController.trip)
            }
            else {
                showAlertOk(title: "Error", message: "Trip Data is not complete")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func startTracking(_ sender: UIBarButtonItem) {
           if let childController = children.first as? AddTripTableViewController {
            if childController.trip.modesOfTravel == nil {
                showAlertOk(title: "Error", message: "please set modes of travel")
            }
            else {
                if(!LocationManager.shared.trackingStarted){
                    sender.title = "stop tracking"
                    UIApplication.shared.isIdleTimerDisabled = true
                    LocationManager.shared.tripDataSetDelegate = childController
                    LocationManager.shared.startTracking(modeOfTravel: childController.trip.modesOfTravel!)
                    
                }
                else {
                    sender.title = "start tracking"
                    UIApplication.shared.isIdleTimerDisabled = false
                    LocationManager.shared.stopTracking()
                    
                    
                }
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setTextField(textField:UITextField){
        if let childController = children.last as? AutoCompleteTableViewController {
            childController.textField = textField;
            if topActualConstraint != nil {
                topActualConstraint?.isActive = false
            }
            topActualConstraint = autoCompleteTableViewContainer.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1)
            topActualConstraint?.isActive = true
        }
    }
    
    func setTripData(placemark:CLPlacemark,textField:UITextField){
        textField.text = placemark.description.components(separatedBy: "@").first
        if textField.tag == 0 {
            if let childController = children.first as? AddTripTableViewController {
                childController.trip.startAddressName = placemark.description.components(separatedBy: "@").first
                childController.trip.startCoordinates = placemark.location
            }
            
        }
        else {
            if let childController = children.first as? AddTripTableViewController {
                childController.trip.endAddressName = placemark.description.components(separatedBy: "@").first
                childController.trip.endCoordinates = placemark.location
            }
        }
        
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
