//
//  LocationTabBarController.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 27/2/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import UIKit

class LocationTabBarController: UITabBarController {

    // MARK: Property
    
    var account : Account?
    var session : Session?
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UdacityClient.logout { isSuccessful, error in
            if (isSuccessful) {
                DispatchQueue.main.async {
                    self.user = nil
                    self.session = nil
                    self.account = nil
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print(error as Any)
            }
        }
    }
}
