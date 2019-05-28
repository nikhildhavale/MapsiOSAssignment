//
//  AutoCompleteTableViewController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 28/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit
import CoreLocation

class AutoCompleteTableViewController: UITableViewController,AutoCompleteDataDelegate {

    var textField:UITextField?
    var placemark = [CLPlacemark]() {
        didSet{
            tableView?.reloadData()
            view?.superview?.isHidden = placemark.count == 0 
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TripListTableViewCell", bundle: nil), forCellReuseIdentifier: StoryBoardConstants.listTripIdentifier)
        
    }
    func sendAutoCompleteData(placemark: [CLPlacemark]) {
        self.placemark = placemark;
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placemark.count
    }

    /*  */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.listTripIdentifier, for: indexPath) as! TripListTableViewCell

        cell.tripLabel.text = placemark[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let parent = self.parent as? AddTripViewController, let field = textField {
            parent.setTripData(placemark: placemark[indexPath.row], textField: field)
            view?.superview?.isHidden = true 
        }
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
