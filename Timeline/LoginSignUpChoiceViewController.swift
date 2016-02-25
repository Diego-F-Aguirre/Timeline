//
//  LoginSignUpChoiceViewController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignUpChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    

  
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        if segue.identifier == "toLogin" {
            let destinationController = segue.destinationViewController as! LoginSignUpViewController
            destinationController.viewMode = LoginSignUpViewController.ViewMode.Login
        } else if segue.identifier == "toSignup" {
            let destinationController = segue.destinationViewController as! LoginSignUpViewController
            destinationController.viewMode = LoginSignUpViewController.ViewMode.Signup
        }
        
    }
    

}
