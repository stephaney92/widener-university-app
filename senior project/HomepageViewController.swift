//
//  HomepageViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 1/28/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import Firebase

class HomepageViewController: UIViewController {

    @IBOutlet weak var licensePlateText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //hides back button on homepage 
        //navigationItem.hidesBackButton = true
    }
    //add code in here to associate data for car to user 
    @IBAction func doneButtonPressed(_ sender: Any) {
        let licensePlate = licensePlateText.text;
        let state = stateText.text;
        
        if (licensePlate!.isEmpty || state!.isEmpty){
            displayMyAlertMessage(userMessage: "All fields are required")
            return
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
    /*@IBAction func LogoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            //pops all view off the stack except the root view and takes you back to root view loginpage
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
            //catch blocked triggered if there are any issues signing out user
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }*/
    
    
    
    
        


    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


