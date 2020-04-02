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
