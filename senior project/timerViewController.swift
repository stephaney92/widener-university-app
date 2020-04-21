//
//  timerViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 3/13/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import MapKit
import Firebase

// protocol used for sending data back
protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}

class timerViewController: UIViewController, MKMapViewDelegate {
   class CustomPointAnnotation: MKPointAnnotation{
       var imageName: String!
   }
 
    @IBOutlet weak var parkingPoint: MKMapView!
    @IBOutlet weak var timerLabel: UILabel!
    var dataFromMap = CLLocationCoordinate2D()

    // making this a weak variable so that it won't create a strong reference cycle
    weak var delegate: DataEnteredDelegate? = nil
    var totalSeconds = 0 //This variable will hold a starting value of seconds. starts clock at 0 until add time is click which will add 30 mins 
    var seconds = 0
    var minutes = 0
    var hours = 0
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var stopTapped = false
    let db = Firestore.firestore()
    let parkSpace = CustomPointAnnotation()
    var dataNamePlate = ""
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the map location to a specific location when the view loads
        let centerLocation = CLLocationCoordinate2DMake(39.863048 , -75.357583)
        //logingitude and latitude that the map will cover
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        //range that the map will show
        let mapRange = MKCoordinateRegion(center: centerLocation, span: mapSpan)
        //what we will see on the map
        self.parkingPoint.setRegion(mapRange, animated: false)
        
        //zooms into location
        /*let viewRegion = MKCoordinateRegion(center: centerLocation, latitudinalMeters: 10, longitudinalMeters: 10)
        parkingPoint.setRegion(viewRegion, animated: false)*/
        
        //addAnnotation()
        parkingPoint.delegate = self
        //pulls annotation coordinates from mapview and places them on timer map
       
        parkSpace.coordinate = dataFromMap
        parkSpace.imageName = "greenticker"
        parkingPoint.addAnnotation(parkSpace)
        
    }
    //checks to see who the current user is and when start is pressed sends their username to the annotation in mapview
    func checkIfUserIsLoggedIn(){
        db.collection("NewUsers").getDocuments() { (querySnapshot, err) in
        for document in querySnapshot!.documents {
            if let names = document.get("username") {
                let currentuser = Auth.auth().currentUser?.email
                if ((currentuser!.isEqual(names))){
                    self.dataNamePlate = currentuser!
                    // call this method on whichever class implements our delegate protocol
                    self.delegate?.userDidEnterInformation(info: self.dataNamePlate)
                    // go back to the previous view controller
                    //self.navigationController?.popViewController(animated: true)
                    print(currentuser!)
                    }
                }
            }
        }
    }
    func checkDatabaseOccupied(){
        let parkingSpots = db.collection("ParkingSpaces")
        
               let userOccupingSpace: String = (Auth.auth().currentUser?.email)!
               db.collection("ParkingSpaces").getDocuments() { (querySnapshot, err) in
                   
                   if let err = err {
                       print("Error getting documents: \(err)")
                   } else {
                       for _ in querySnapshot!.documents {
                           
                           print(self.dataFromMap.latitude)
                           print(self.dataFromMap.longitude)
                           
                           /*if (self.dataFromMap.latitude == 39.863250 && self.dataFromMap.longitude == -75.357813) {
                               parkingSpots.document("parkSpaceOne").updateData([
                                   "spaceAvailability": false
                               ])
                           }*/
                           if (self.dataFromMap.latitude == 39.863264 && self.dataFromMap.longitude == -75.357862) {
                               parkingSpots.document("parkSpaceTwo").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                               
                           }
                           else if (self.dataFromMap.latitude == 39.863180 && self.dataFromMap.longitude == -75.357891) {
                               parkingSpots.document("parkSpaceThree").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863083 && self.dataFromMap.longitude == -75.357781) {
                               parkingSpots.document("parkSpaceEight").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.862910 && self.dataFromMap.longitude == -75.357725) {
                               parkingSpots.document("parkSpaceFifteen").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           /*else if (self.dataFromMap.latitude == 39.862774 && self.dataFromMap.longitude == -75.357587) {
                               parkingSpots.document("parkSpaceTwentyTwo").updateData([
                                   "spaceAvailability": false
                               ])
                           }*/
                           else if (self.dataFromMap.latitude == 39.862736 && self.dataFromMap.longitude == -75.357478) {
                               parkingSpots.document("parkSpaceTwentyFour").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           /*else if (self.dataFromMap.latitude == 39.862789 && self.dataFromMap.longitude == -75.357254) {
                               parkingSpots.document("parkSpaceThirtyOne").updateData([
                                   "spaceAvailability": false
                               ])
                           }*/
                           else if (self.dataFromMap.latitude == 39.862967 && self.dataFromMap.longitude == -75.357321) {
                               parkingSpots.document("parkSpaceThirtyThree").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863113 && self.dataFromMap.longitude == -75.357450) {
                               parkingSpots.document("parkSpaceForty").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863203 && self.dataFromMap.longitude == -75.357506) {
                               parkingSpots.document("parkSpaceFortyFour").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863328 && self.dataFromMap.longitude == -75.357542) {
                               parkingSpots.document("parkSpaceFortyNine").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863340 && self.dataFromMap.longitude == -75.357649) {
                               parkingSpots.document("parkSpaceFiftyOne").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863152 && self.dataFromMap.longitude == -75.357674) {
                               parkingSpots.document("parkSpaceFiftyFive").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863018 && self.dataFromMap.longitude == -75.357588) {
                               parkingSpots.document("parkSpaceSixty").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.862885 && self.dataFromMap.longitude == -75.357503) {
                               parkingSpots.document("parkSpaceSixtySix").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863174 && self.dataFromMap.longitude == -75.357608) {
                               parkingSpots.document("parkSpaceSixtyNine").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863036 && self.dataFromMap.longitude == -75.357542) {
                               parkingSpots.document("parkSpaceSeventyFour").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.862907 && self.dataFromMap.longitude == -75.357441) {
                               parkingSpots.document("parkSpaceEightyOne").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863365 && self.dataFromMap.longitude == -75.357505) {
                               parkingSpots.document("parkSpaceEightyThree").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863269 && self.dataFromMap.longitude == -75.357398) {
                               parkingSpots.document("parkSpaceEightyEight").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863144 && self.dataFromMap.longitude == -75.357370) {
                               parkingSpots.document("parkSpaceNinetyThree").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           /*else if (self.dataFromMap.latitude == 39.863001 && self.dataFromMap.longitude == -75.357234) {
                               parkingSpots.document("parkSpaceOneHundred").updateData([
                                   "spaceAvailability": false
                               ])
                           }*/
                           else if (self.dataFromMap.latitude == 39.863493 && self.dataFromMap.longitude == -75.357277) {
                               parkingSpots.document("parkSpaceOneHundredFourteen").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863436 && self.dataFromMap.longitude == -75.357352) {
                               parkingSpots.document("parkSpaceOneHundredSeventeen").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863252 && self.dataFromMap.longitude == -75.357221) {
                               parkingSpots.document("parkSpaceOneHundredEighteen").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863167 && self.dataFromMap.longitude == -75.357214) {
                               parkingSpots.document("parkSpaceOneHundredTwentyTwo").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           /*else if (self.dataFromMap.latitude == 39.863111 && self.dataFromMap.longitude == -75.357136) {
                               parkingSpots.document("parkSpaceOneHundredTwentyFive").updateData([
                                   "spaceAvailability": false
                               ])
                           }
                           else if (self.dataFromMap.latitude == 39.863135 && self.dataFromMap.longitude == -75.357074) {
                               parkingSpots.document("parkSpaceOneHundredTwentySix").updateData([
                                   "spaceAvailability": false
                               ])
                           }*/
                           else if (self.dataFromMap.latitude == 39.863190 && self.dataFromMap.longitude == -75.357153) {
                               parkingSpots.document("parkSpaceOneHundredTwentyNine").updateData([
                                   "spaceAvailability": false, "OccupiedBy": userOccupingSpace
                               ])
                           }
                           /*else if (self.dataFromMap.latitude == 39.863274 && self.dataFromMap.longitude == -75.357205) {
                               parkingSpots.document("parkSpaceOneHundredThirtyThree").updateData([
                                   "spaceAvailability": false
                               ])
                           }*/
                       }
                   }
                   
               }
    }
    func checkDatabaseAvailible(){
        let parkingSpots = db.collection("ParkingSpaces")
        
        db.collection("ParkingSpaces").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for _ in querySnapshot!.documents {
                    
                    print(self.dataFromMap.latitude)
                    print(self.dataFromMap.longitude)
                    
                    /*if (self.dataFromMap.latitude == 39.863250 && self.dataFromMap.longitude == -75.357813) {
                        parkingSpots.document("parkSpaceOne").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }*/
                    if (self.dataFromMap.latitude == 39.863264 && self.dataFromMap.longitude == -75.357862) {
                        parkingSpots.document("parkSpaceTwo").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863180 && self.dataFromMap.longitude == -75.357891) {
                        parkingSpots.document("parkSpaceThree").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863083 && self.dataFromMap.longitude == -75.357781) {
                        parkingSpots.document("parkSpaceEight").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.862910 && self.dataFromMap.longitude == -75.357725) {
                        parkingSpots.document("parkSpaceFifteen").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    /*else if (self.dataFromMap.latitude == 39.862774 && self.dataFromMap.longitude == -75.357587) {
                        parkingSpots.document("parkSpaceTwentyTwo").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }*/
                    else if (self.dataFromMap.latitude == 39.862736 && self.dataFromMap.longitude == -75.357478) {
                        parkingSpots.document("parkSpaceTwentyFour").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    /*else if (self.dataFromMap.latitude == 39.862789 && self.dataFromMap.longitude == -75.357254) {
                        parkingSpots.document("parkSpaceThirtyOne").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }*/
                    else if (self.dataFromMap.latitude == 39.862967 && self.dataFromMap.longitude == -75.357321) {
                        parkingSpots.document("parkSpaceThirtyThree").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863113 && self.dataFromMap.longitude == -75.357450) {
                        parkingSpots.document("parkSpaceForty").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863203 && self.dataFromMap.longitude == -75.357506) {
                        parkingSpots.document("parkSpaceFortyFour").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863328 && self.dataFromMap.longitude == -75.357542) {
                        parkingSpots.document("parkSpaceFortyNine").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863340 && self.dataFromMap.longitude == -75.357649) {
                        parkingSpots.document("parkSpaceFiftyOne").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863152 && self.dataFromMap.longitude == -75.357674) {
                        parkingSpots.document("parkSpaceFiftyFive").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863018 && self.dataFromMap.longitude == -75.357588) {
                        parkingSpots.document("parkSpaceSixty").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.862885 && self.dataFromMap.longitude == -75.357503) {
                        parkingSpots.document("parkSpaceSixtySix").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863174 && self.dataFromMap.longitude == -75.357608) {
                        parkingSpots.document("parkSpaceSixtyNine").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863036 && self.dataFromMap.longitude == -75.357542) {
                        parkingSpots.document("parkSpaceSeventyFour").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.862907 && self.dataFromMap.longitude == -75.357441) {
                        parkingSpots.document("parkSpaceEightyOne").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863365 && self.dataFromMap.longitude == -75.357505) {
                        parkingSpots.document("parkSpaceEightyThree").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863269 && self.dataFromMap.longitude == -75.357398) {
                        parkingSpots.document("parkSpaceEightyEight").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863144 && self.dataFromMap.longitude == -75.357370) {
                        parkingSpots.document("parkSpaceNinetyThree").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    /*else if (self.dataFromMap.latitude == 39.863001 && self.dataFromMap.longitude == -75.357234) {
                        parkingSpots.document("parkSpaceOneHundred").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }*/
                    else if (self.dataFromMap.latitude == 39.863493 && self.dataFromMap.longitude == -75.357277) {
                        parkingSpots.document("parkSpaceOneHundredFourteen").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863436 && self.dataFromMap.longitude == -75.357352) {
                        parkingSpots.document("parkSpaceOneHundredSeventeen").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863252 && self.dataFromMap.longitude == -75.357221) {
                        parkingSpots.document("parkSpaceOneHundredEighteen").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863167 && self.dataFromMap.longitude == -75.357214) {
                        parkingSpots.document("parkSpaceOneHundredTwentyTwo").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    /*else if (self.dataFromMap.latitude == 39.863111 && self.dataFromMap.longitude == -75.357136) {
                        parkingSpots.document("parkSpaceOneHundredTwentyFive").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    else if (self.dataFromMap.latitude == 39.863135 && self.dataFromMap.longitude == -75.357074) {
                        parkingSpots.document("parkSpaceOneHundredTwentySix").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }*/
                    else if (self.dataFromMap.latitude == 39.863190 && self.dataFromMap.longitude == -75.357153) {
                        parkingSpots.document("parkSpaceOneHundredTwentyNine").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }
                    /*else if (self.dataFromMap.latitude == 39.863274 && self.dataFromMap.longitude == -75.357205) {
                        parkingSpots.document("parkSpaceOneHundredThirtyThree").updateData([
                            "spaceAvailability": true, "OccupiedBy": ""
                        ])
                    }*/
                }
            }
            
        }
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        checkIfUserIsLoggedIn()
        //creates one timer when start is pressed
        if isTimerRunning == false{
            runTimer()
            
            //start is pressed it sends plate name to map controller and updates subtitle 
           
           // self.dataNamePlate = namePlate as! String
           /* db.collection("ParkingSpaces").getDocuments() { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                if let coords = document.get("location") {
                        let point = coords as! GeoPoint
                        let lat = point.latitude
                        let lon = point.longitude
                    if (self.dataFromMap.latitude == lat && self.dataFromMap.longitude == lon){
                        let data = document.data()
                        let spaceAvailible = data["spaceAvailability"] as? Bool
                        let spaceTakenBy = data["OccupiedBy"] as? String
                        let documentId = document.documentID
                            
                            
                        }
                    }
                }
            }*/
            // call this method on whichever class implements our delegate protocol
           // delegate?.userDidEnterInformation(info: dataNamePlate)

            // go back to the previous view controller
            //self.navigationController?.popViewController(animated: true)
        
        }

        checkDatabaseOccupied()
        
    }
    
    //timeInterval - how often the a method will be called, selector - method being called updateTimer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    //if time is less then 1 stop timer else keep counting down
    @objc func updateTimer() {
        if totalSeconds < 1 {
             timer.invalidate()
            checkDatabaseAvailible()
             
             //Send alert to indicate "time's up!" UI alert
        } else {
            totalSeconds = totalSeconds - 1
             timerLabel.text = timeString(time: TimeInterval(totalSeconds)) //This will update the label. This will send it through the timeString method where it will be formatted first and then set as the text label
            
        }
    }
    
    //The first time the stop button is tapped the resumeTapped will be false and the timer will be stopped with timer.invalidate(), else The following time the pause button is tapped runTimer() will again initialize the timer
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if self.stopTapped == false {
                 timer.invalidate()
                 totalSeconds = 0 //timer is now at 0
                 timerLabel.text = timeString(time: TimeInterval(totalSeconds))
                 /*self.resumeTapped = true
            } else {
                 runTimer()
                 self.resumeTapped = false
            }*/
        }
        checkDatabaseAvailible();
        
    }
    
    //stops timer and resets the clock back to zero
    @IBAction func addButtonPressed(_ sender: UIButton) {
         totalSeconds += 15//1800 //adds 30 mins to timer
         
        //takes code from this function sends to string function to send to label in timerviewcontroller
         timerLabel.text = timeString(time: TimeInterval(totalSeconds))
         
         isTimerRunning = false
    }
    
    //It will take a time interval or Integer and return a String with the formatted time. The label will now update using this string. create a seconds, hours, mins
    func timeString(time:TimeInterval) -> String {
         let hours = totalSeconds / 3600
         let minutes = (totalSeconds % 3600) / 60
         let seconds = (totalSeconds % 3600) % 60

        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //adds annotations to map view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { return nil }

    let identifier = "Annotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    //transforms marker to pin
    if annotationView == nil {
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView!.canShowCallout = true
        
        //creates button in pop up
       let btn = UIButton(type: .detailDisclosure)
        annotationView!.rightCalloutAccessoryView = btn
    }
    else {
        annotationView!.annotation = annotation
    }
    //can call the different annotaiton pictures per ticker
    let cpa = annotation as! CustomPointAnnotation
    annotationView!.image = UIImage(named: cpa.imageName)
     
    
    return annotationView
    }
}
