//
//  Extension.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 30/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlertOk(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
