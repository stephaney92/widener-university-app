//
//  createAccountViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 1/28/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import Firebase

class createAccountViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createButtonPressed(_ sender: Any) {
        //both can not be nil to work, email/password must be entered to trigger auth
        if let email = userEmail.text, let password = userPassword.text{
            //uses email and password typed in by users to create an account
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //checking for errors if theres an error then message will be printed
                if let e = error{
                    print(e)
                }else{
                    //if no errors then account is create and user is navigated to homepage
                    self.performSegue(withIdentifier: "Registertoapp", sender: self)
                    //takes user from from register page to homepage
                    //self is the origin of the segue which is the registration page
                }
            }
        }
}
}
