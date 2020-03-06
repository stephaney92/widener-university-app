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
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPlate: UITextField!
    @IBOutlet weak var userCarName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
   

    @IBAction func createButtonPressed(_ sender: UIButton) {
        let nameText = userName.text;
        let userEmailText = userEmail.text;
        let userPasswordText = userPassword.text;
        let userPlateText = userPlate.text;
        let userCar = userCarName.text;
        
        //reference to firestore database, run methods and commmands to firestore database
        let db = Firestore.firestore()
        
        //adding username to database
        //firbase send data to server side and store in database
        // Add a new document with a userName generated ID by user with name
        // var ref: DocumentReference? = nil
        

        //check to see if fields are empty
        if (userEmailText!.isEmpty || userPasswordText!.isEmpty || nameText!.isEmpty || userPlateText!.isEmpty || userCar!.isEmpty){
            displayMyAlertMessage(userMessage: "All fields are required")
            return
        }
        
        //both can not be nil to work, email/password must be entered to trigger auth
        if let email = userEmail.text, let password = userPassword.text{
            //uses email and password typed in by users to create an account
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //checking for errors if theres an error then message will be printed
                if let e = error{
                    print(e)
                }else{
                    //if no errors then account is create and user is navigated to homepage
                    self.performSegue(withIdentifier: constants.createAccountSegue, sender: self)
                    //takes user from from register page to homepage
                    //self is the origin of the segue which is the registration page
                    //add new users in new user collection
                    db.collection("NewUsers").document(self.userName.text!).setData(["username" : self.userEmail.text!, "plate": self.userPlate.text!, "uid": authResult!.user.uid])
                        { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            }
                           
                    }
                   /* db.collection("NewUsers").document(self.userName.text!).collection("Cars").document(self.userCarName.text!).setData(["username" : self.userEmail.text!, "plate": self.userPlate.text!, "uid": authResult!.user.uid])
                        { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            }
                           
                    }*/
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
