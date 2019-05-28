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
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let childController = children.first as? AddTripTableViewController , let autoCompleteController = children.last as? AutoCompleteTableViewController  {
            childController.delegate = autoCompleteController
        }
    }
    @IBAction func doneButtonClicked(_ sender: Any) {
        if let childController = children.first as? AddTripTableViewController {
            if(childController.trip.isTripDataComplete()){
                addTripDelegate?.addTrip(trip: childController.trip)
            }
        }
        self.dismiss(animated: true, completion: nil)
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
