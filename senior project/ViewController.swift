//
//  ViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 1/27/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    //email and password variables for login page 
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loginPressed(_ sender: Any) {
        if let email = userEmail.text, let password = userPassword.text{
        //uses the existing email and password from firbase to login to homepage
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if let e = error{
                print(e)
            }else{
                //if no errors then user is navigated to homepage
                self.performSegue(withIdentifier: "logintohomepage", sender: self)
                //takes user from from login page to homepage
                //self is the origin of the segue which is the registration page
                }
            }
        }
    }
}

