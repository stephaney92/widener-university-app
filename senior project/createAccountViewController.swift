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
        let userEmailText = userEmail.text;
        let userPasswordText = userPassword.text;
        
        //check to see if fields are empty
        if (userEmailText!.isEmpty || userPasswordText!.isEmpty){
            displayMyAlertMessage(userMessage: "All fields are required")
            return
        }
        //firbase send data to server side and store in database
        
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
    
    //alert display on view controller
    func displayMyAlertMessage(userMessage: String){
        let myAlert = UIAlertController(title: "Alert" , message: userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title: "Ok" , style: UIAlertAction.Style.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert , animated: true, completion: nil);
    }
    
}
