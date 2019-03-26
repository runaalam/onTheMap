//
//  AddLocationViewController.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 27/2/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.delegate = self
        websiteTextField.delegate = self
        setActivityIndicator(false)
    }
    
    func setActivityIndicator(_ isActive: Bool) {
        activityIndicator.isHidden = !isActive
        if isActive {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        locationTextField.isEnabled = !isActive
        websiteTextField.isEnabled = !isActive
        findLocationButton.isEnabled = !isActive
       
    }
    
    //MARK: IBAction
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationPressed(_ sender: Any) {
        setActivityIndicator(true)
    }
}
