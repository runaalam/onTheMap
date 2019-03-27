//
//  LoginViewController.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 27/2/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: Property
    
    var account: Account!
    var session: Session!
    var user: User!
    
    // MARK: override function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.LOCATION_TAB_IDENTIFIER {
            if let navigationController = segue.destination as? UINavigationController,
            let tabController = navigationController.visibleViewController as? LocationTabBarController {
                    tabController.account = self.account
                    tabController.session = self.session
                    tabController.user = self.user
                }
            setActivityIndicator(false)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func logInTapped(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                showErrorAlert(title: "", message: Massages.EMPTY_USER_PASS)
                return
        }
        
        // Enable activity indicator
        setActivityIndicator(true)
        
        UdacityClient.userlogin(username: username, password: password) {account, session, error in
            
            guard error == nil else {
                self.setActivityIndicator(false)
                self.showErrorAlert(title: "", message: Massages.INCORRECT_USER_PASS)
                return
            }
            
            self.account = account
            self.session = session
            
            UdacityClient.getUserInfo(userID: account!.accountkey){
                user, error in
                
                self.setActivityIndicator(true)
                print(user as Any)
                guard error == nil else {
                    self.showErrorAlert(title: "Error", message: Massages.NO_USER_DETAILS)
                    return
                }
                
                self.user = user
                DispatchQueue.main.async {
                    // Re-enable views when request finishes.
                    self.performSegue(withIdentifier: Identifiers.LOCATION_TAB_IDENTIFIER, sender: self)
                }
            }
        }
    }

    @IBAction func signUpTapped(_ sender: Any) {
        let url = URL (string: "https://auth.udacity.com/sign-up")
        UIApplication.shared.open(url!)
    }

    // MARK: Textfield Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Active and Deactivate Activity indicator
    
    func setActivityIndicator(_ isActive: Bool) {
        if isActive {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        usernameTextField.isEnabled = !isActive
        passwordTextField.isEnabled = !isActive
        logInButton.isEnabled = !isActive
        signUpButton.isEnabled = !isActive
    }
    
    // MARK: Method to show Alert Massage
    
    func showErrorAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}


