//
//  FirstViewController.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 26/2/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    //MARK: IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Properties
    var annotations = [MKPointAnnotation]()
    var stdLocationList = [StudentInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        getLocationList()
    }
    
    func getLocationList() {
        let tableTab = self.tabBarController!.viewControllers![1] as! LocationTableController
        ParseClient.getStudentInformationList() { locationList, error in
            if !locationList.isEmpty {
                self.stdLocationList = locationList
                self.getAnnotationList()
                tableTab.stdLocationList = locationList
            }
        }
    }
    
    func getAnnotationList(){
        for dictionary in self.stdLocationList {
            var annotation: MKPointAnnotation
            annotation = setAnnotation(studentInfo: dictionary)
            self.annotations.append(annotation)
        }
        self.mapView.addAnnotations(self.annotations)
    }

    func setAnnotation(studentInfo: StudentInformation) -> MKPointAnnotation {
        let lat = CLLocationDegrees(studentInfo.latitude!)
        let long = CLLocationDegrees(studentInfo.longitude!)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

        let first = studentInfo.firstName
        let last = studentInfo.lastName
        let mediaURL = studentInfo.mediaUrl
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = (first)! + " " + (last)!
        annotation.subtitle = mediaURL
        return annotation
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
               app.open(URL(string: toOpen)!)
            }
        }
    }
}

