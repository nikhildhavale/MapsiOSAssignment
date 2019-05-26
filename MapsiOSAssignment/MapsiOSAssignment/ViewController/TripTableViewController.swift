//
//  TripTableViewController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit
import CoreLocation
class TripTableViewController: UITableViewController {
    var tripList = [Trip]()
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleData()
        tableView.register(UINib(nibName: "TripListTableViewCell", bundle: nil), forCellReuseIdentifier: StoryBoardConstants.listTripIdentifier)
        tableView.tableFooterView = UIView()
    }
    func loadSampleData(){
        var trip = Trip()
        trip.modesOfTravel = ModesOfTravel.driving
        trip.startAddressName = "Pune, Maharashtra, India"
        trip.startCoordinates = CLLocation(latitude: 18.520430299999997, longitude: 72.8776559)
        trip.endAddressName = "Mumbai, Maharashtra, India"
        trip.endCoordinates = CLLocation(latitude: 19.0759837, longitude: 73.8567437)
        tripList.append(trip)
        trip = Trip()
        trip.modesOfTravel = ModesOfTravel.walking
        trip.startAddressName = "Pune, Maharashtra, India"
        trip.startCoordinates = CLLocation(latitude: 18.520430299999997, longitude: 72.8776559)
        trip.endAddressName = "Mumbai, Maharashtra, India"
        trip.endCoordinates = CLLocation(latitude: 19.0759837, longitude: 73.8567437)
        tripList.append(trip)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tripList.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.listTripIdentifier, for: indexPath) as! TripListTableViewCell
        cell.tripLabel.text = tripList[indexPath.row].getTripInfoString();
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.parent?.performSegue(withIdentifier: StoryBoardConstants.mapDetailsSegue, sender: tripList[indexPath.row])
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
