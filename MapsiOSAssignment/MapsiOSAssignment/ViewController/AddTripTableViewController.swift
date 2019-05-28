//
//  AddTripTableViewController.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 26/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit
import CoreLocation
class AddTripTableViewController: UITableViewController,UITextFieldDelegate {
    var trip:Trip = Trip()
    let geoCoder = CLGeocoder()
    weak var delegate:AutoCompleteDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "EditTextTableViewCell", bundle: nil), forCellReuseIdentifier: StoryBoardConstants.addTripTextFieldIdentifier)
        tableView.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: StoryBoardConstants.addTripTSwitchIdentifier)
        tableView.tableFooterView = UIView()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell(frame: CGRect.zero);

        switch indexPath.row {

        case 0:
            let addCell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.addTripTextFieldIdentifier, for: indexPath) as! EditTextTableViewCell
            addCell.tag = indexPath.row
            addCell.textField.placeholder = PlaceHolderText.startAddress
            addCell.textField.delegate = self
            addCell.textField.tag = indexPath.row
            cell = addCell
        case 1:
            let addCell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.addTripTextFieldIdentifier, for: indexPath) as! EditTextTableViewCell
            addCell.tag = indexPath.row
            addCell.textField.placeholder = PlaceHolderText.endAddress
            addCell.textField.delegate = self
            addCell.textField.tag = indexPath.row

            cell = addCell
        case 2:
             let switchCell  = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.addTripTSwitchIdentifier, for: indexPath) as! SwitchTableViewCell
             switchCell.uiSwitch.addTarget(self, action: #selector(switchButton(uiSwitch:)), for: .valueChanged)
             switchCell.titleLabel.text = ModesOfTravel.driving.rawValue
             switchCell.uiSwitch.tag = indexPath.row
             switchCell.tag = indexPath.row
             cell = switchCell
        case 3:
            let switchCell  = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.addTripTSwitchIdentifier, for: indexPath) as! SwitchTableViewCell
            switchCell.uiSwitch.addTarget(self, action: #selector(switchButton(uiSwitch:)), for: .valueChanged)
            switchCell.titleLabel.text = ModesOfTravel.walking.rawValue
            switchCell.uiSwitch.tag = indexPath.row
            switchCell.tag = indexPath.row

            cell = switchCell
        default:break
            
        }
        return cell
        // Configure the cell...

    }
    @objc func switchButton(uiSwitch:UISwitch){
        for cell in tableView.visibleCells {
            if let switchCell = cell as? SwitchTableViewCell {
                if switchCell.tag != uiSwitch.tag {
                    switchCell.uiSwitch.isOn = false
                }
            }
        }
        if uiSwitch.tag == 2 {
            trip.modesOfTravel = ModesOfTravel.driving
        }
        else {
            trip.modesOfTravel = ModesOfTravel.walking

        }
            
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let parent = self.parent as? AddTripViewController {
            parent.setTextField(textField: textField)
        }
        return true
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let addCell = cell as? EditTextTableViewCell {
            if addCell.tag == 0 {
                trip.startAddressName = addCell.textField.text
            }
            else {
                trip.endAddressName = addCell.textField.text

            }
        }
        else if let switchCell = cell as? SwitchTableViewCell {
            if switchCell.tag == 2 {
                trip.modesOfTravel = ModesOfTravel.driving
            }
            else {
                trip.modesOfTravel = ModesOfTravel.walking

            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if var completeText = textField.text {
            completeText += string
            if completeText.count > 2 {
                geoCoder.geocodeAddressString(completeText, completionHandler: {(placemark,error) in
                    if let placemarkArray = placemark {
                        self.delegate?.sendAutoCompleteData(placemark: placemarkArray)
                    }
                })
            }
        }
        
        return true
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
