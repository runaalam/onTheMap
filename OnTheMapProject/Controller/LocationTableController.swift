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
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: Table view data source methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stdLocationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.LOCATION_CELL_IDENTIFIER , for: indexPath)
        
        let currentLocation = stdLocationList[indexPath.row]
        cell.textLabel?.text = "\(String(describing: currentLocation.firstName!)) \(String(describing: currentLocation.lastName!))"
        cell.detailTextLabel?.text = currentLocation.mediaUrl
        
        return cell
    }
    
    // MARK: Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentLocation = stdLocationList[indexPath.row]
        UIApplication.shared.open(URL(string: currentLocation.mediaUrl!)!)
    }
    
}

