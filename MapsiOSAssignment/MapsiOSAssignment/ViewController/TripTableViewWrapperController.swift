//
//  TripTableViewWrapperController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit
protocol AddTripDelegate:class {
    func addTrip(trip:Trip)
}
class TripTableViewWrapperController: UIViewController,AddTripDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func addTrip(trip: Trip) {
        if let destination = self.children.first as? TripTableViewController{
            destination.tripList.append(trip)
            destination.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation  */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapViewController {
            if let trip = sender as? Trip{
                destination.trip = trip;
            }
        }
        else if let destination = segue.destination as? UINavigationController {
            if let addTripTableViewController = destination.topViewController as? AddTripViewController {
                addTripTableViewController.addTripDelegate = self 
            }
        }
    }
 

}
