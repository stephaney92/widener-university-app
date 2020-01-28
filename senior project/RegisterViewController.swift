//
//  RegisterViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 1/27/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        //both can not be nil to work, email/password must be entered to trigger auth
        if let email = userEmailText.text, let password = userPasswordText.text{
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
