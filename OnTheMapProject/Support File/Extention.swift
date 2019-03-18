//
//  ExtentionClasses.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 28/2/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // Returns a string in which the key is substituted with the given value, if found.
    func byReplacingKey(_ key: String, withValue value: String) -> String {
        return replacingOccurrences(of: "{\(key)}", with: value)
    }
}

extension DateFormatter {
    static let APIFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
    }()
}

extension NSNotification.Name {
    static let StudentInformationCreated = NSNotification.Name("student_notification_created")
}

extension UIViewController {
       
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


