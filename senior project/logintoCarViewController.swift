//
//  logintoCarViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 2/20/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import Firebase

class logintoCarViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
   /* override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }*/
    @IBAction func LoginBPressed(_ sender: UIButton) {
        let userEmailText = userEmail.text;
        let userPasswordText = userPassword.text;
        if (userEmailText!.isEmpty || userPasswordText!.isEmpty){
            displayMyAlertMessage(userMessage: "All fields are required")
            return
        }
        if let email = userEmail.text, let password = userPassword.text{
            //uses the existing email and password from firbase to login to homepage
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error{
                print(e)
            }else{
            //if no errors then user is navigated to map page
               self?.performSegue(withIdentifier: constants.loginSegue, sender: self)
            //takes user from from login page to homepage
            //self is the origin of the segue which is the registration page
         
                }
            }
        }
    }
    
    func displayMyAlertMessage(userMessage: String){
        let myAlert = UIAlertController(title: "Alert" , message: userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title: "Ok" , style: UIAlertAction.Style.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert , animated: true, completion: nil);
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


