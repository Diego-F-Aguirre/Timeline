//
//  LoginSignUpViewController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var websiteURLTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
   var viewMode: ViewMode = .Signup
    
    var user: User?
    
    enum ViewMode {
        case Login
        case Signup
        case Edit
 
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let user = user {
            
            updateWithUser(user)
            
        }
        
         updateViewBasedOnMode()
        
        
    }
    
     
    
    func updateViewBasedOnMode() {
        
        switch viewMode {
        case .Signup : (usernameTextField.hidden = false, emailTextField.hidden = false, passwordTextField.hidden = false, bioTextField.hidden = false, websiteURLTextField.hidden = false, actionButton.setTitle("Sign Up", forState: .Normal))
        case .Login: (usernameTextField.hidden = true, emailTextField.hidden = false, passwordTextField.hidden = false, bioTextField.hidden = true, websiteURLTextField.hidden = true, actionButton.setTitle("Login", forState: .Normal))
        case .Edit: (emailTextField.hidden = true, passwordTextField.hidden = true, actionButton.setTitle("Update", forState: .Normal))
            
        if let user = self.user {
            usernameTextField.text = user.username
            bioTextField.text = user.bio
            websiteURLTextField.text = user.url
            }
        }
    }
    
    var fieldsAreValid: Bool {
        
        get {
            switch viewMode {
                
            case .Signup:
                return !(usernameTextField.text!.isEmpty && emailTextField.text!.isEmpty && passwordTextField.text!.isEmpty)
            case .Login:
                return !(emailTextField.text!.isEmpty && passwordTextField.text!.isEmpty)
            case .Edit:
                return (emailTextField.text?.isEmpty)!
            }
        }
    }
    
    func updateWithUser(user: User) {
        self.user = user
        viewMode = .Edit
    }
    
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        
        if fieldsAreValid {
            switch viewMode {
                
            case .Signup:
                UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text!, url: bioTextField.text, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable To Sign Up", message: "Please check your information and try again")
                    }
                })
                
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Log In", message: "Please re-check your information and try again")
                    }
                })
                
            case .Edit:
                UserController.updateUser(self.user!, username: self.usernameTextField.text!, bio: self.bioTextField.text, url: self.websiteURLTextField.text, completion: { (success, user) -> Void in
                    
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Update User", message: "Please check your information and try again.")
                    }
                })
            }
        } else {
            presentValidationAlertWithTitle("Missing information", message: "Please check your information and try again.")
        }
        
    }
    
    
    func presentValidationAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
