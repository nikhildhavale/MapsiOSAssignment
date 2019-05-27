//
//  AddTripViewController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {
    weak var addTripDelegate:AddTripDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        if let childController = children.first as? AddTripTableViewController {
            addTripDelegate?.addTrip(trip: childController.trip)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
