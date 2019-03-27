//
//  SecondViewController.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 26/2/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import UIKit

class LocationTableController: UITableViewController {

    var stdLocationList = [StudentInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("====== I M TABLE PRINT \(String(describing: self.stdLocationList.count)) =====")
    }


}

