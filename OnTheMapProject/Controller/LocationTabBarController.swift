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
    var studentLocationList = [StudentInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("=============================")
        print(account?.accountkey as Any)
        print(session?.sessionId as Any)
        print(self.studentLocationList.count)
    }
    
    @IBAction func addLocationPressed(_ sender: Any) {
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
    
    // NEED to remove later
    
    func hardCodedLocationData() -> [[String : Any]] {
        return  [
            [
                "createdAt" : "2015-02-24T22:27:14.456Z",
                "firstName" : "Jessica",
                "lastName" : "Uelmen",
                "latitude" : 28.1461248,
                "longitude" : -82.75676799999999,
                "mapString" : "Tarpon Springs, FL",
                "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
                "objectId" : "kj18GEaWD8",
                "uniqueKey" : 872458750,
                "updatedAt" : "2015-03-09T22:07:09.593Z"
            ], [
                "createdAt" : "2015-02-24T22:35:30.639Z",
                "firstName" : "Gabrielle",
                "lastName" : "Miller-Messner",
                "latitude" : 35.1740471,
                "longitude" : -79.3922539,
                "mapString" : "Southern Pines, NC",
                "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
                "objectId" : "8ZEuHF5uX8",
                "uniqueKey" : 2256298598,
                "updatedAt" : "2015-03-11T03:23:49.582Z"
            ], [
                "createdAt" : "2015-02-24T22:30:54.442Z",
                "firstName" : "Jason",
                "lastName" : "Schatz",
                "latitude" : 37.7617,
                "longitude" : -122.4216,
                "mapString" : "18th and Valencia, San Francisco, CA",
                "mediaURL" : "http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
                "objectId" : "hiz0vOTmrL",
                "uniqueKey" : 2362758535,
                "updatedAt" : "2015-03-10T17:20:31.828Z"
            ], [
                "createdAt" : "2015-03-11T02:48:18.321Z",
                "firstName" : "Jarrod",
                "lastName" : "Parkes",
                "latitude" : 33.922370,
                "longitude" : 151.068069,
                "mapString" : "Huntsville, Alabama",
                "mediaURL" : "https://linkedin.com/in/jarrodparkes",
                "objectId" : "CDHfAy8sdp",
                "uniqueKey" : 996618664,
                "updatedAt" : "2015-03-13T03:37:58.389Z"
            ]
        ]
    }
    
}
