//
//  mapViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 2/18/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class mapViewController: UIViewController, MKMapViewDelegate{

    //class so an image can be added to point annotation
    class CustomPointAnnotation: MKPointAnnotation{
        var imageName: String!
    }
    @IBOutlet weak var map: MKMapView!
    var plateName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = nil;
        
        //set the map location to a specific location when the view loads
        let centerLocation = CLLocationCoordinate2DMake(39.863048 , -75.357583)
        //logingitude and latitude that the map will cover
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        //range that the map will show
        let mapRange = MKCoordinateRegion(center: centerLocation, span: mapSpan)
        //what we will see on the map
        self.map.setRegion(mapRange, animated: false)
        
       
        
        //addAnnotation()
        map.delegate = self
        
        let rotate = CGFloat(180)
        let regionradius : CLLocationDistance=300.0
        let region = MKCoordinateRegion(center: centerLocation, latitudinalMeters: regionradius, longitudinalMeters: regionradius)
        
        //rotation that shows the map is alligned
        map.camera.pitch = rotate;
        map.setRegion(region, animated: true)
        map.delegate = self
        map.isUserInteractionEnabled = true
        
        //allows user to still interact with the items on map
        let pitch: CGFloat = 300
        let heading = 335.0
        var camera: MKMapCamera?
        camera = MKMapCamera(lookingAtCenter: centerLocation, fromDistance: regionradius, pitch: pitch, heading: heading)
        map.camera = camera!
        
        //disables clickables on map
        map.isRotateEnabled = false;
        map.isZoomEnabled = false;
        map.isScrollEnabled = false;
        map.showsCompass = false;
       
        
        //intializing annotations making them points
        let parkSpaceOne = CustomPointAnnotation()
        let parkSpaceTwo = CustomPointAnnotation()
        var points: [CustomPointAnnotation] = []
        let db = Firestore.firestore()
        
            //grabs all the coordinates of the parking spaces in firebase
            db.collection("ParkingSpaces").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let coords = document.get("location") {
                            let point = coords as! GeoPoint
                            let lat = point.latitude
                            let lon = point.longitude
                            
                            
                            //string variable for spot field in firebase
                            let spotpone = document.get("spot") as! String
                            let spotptwo = document.get("spot") as! String
                            //if the spot in firbase matches the string then take the coordinates, add them to an annotation and place on the map
                            if (spotpone == "p1"){
                                parkSpaceOne.title = "P1"
                                //PLACE HERE if statement if boolean true then is occupied else is availible
                                parkSpaceOne.subtitle = self.plateName
                                parkSpaceOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                parkSpaceOne.imageName = "greenticker"
                               //self.map.addAnnotation(parkSpaceOne)
                                points.append(parkSpaceOne)
                            
                            }
                            else if (spotptwo == "p2"){
                                parkSpaceTwo.title = "P2"
                                parkSpaceTwo.subtitle = self.plateName
                                parkSpaceTwo.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                parkSpaceTwo.imageName = "greenticker"
                                //self.map.addAnnotation(parkSpaceTwo)
                                points.append(parkSpaceTwo)
                            }
                        }
                      }
                    
                    }
                    for i in points{
                        self.map.addAnnotation(i)
                    }
            }
    }
    //turns MKKPointAnnotations into MkPinAnnotations
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
   //clicking on the button checks to see if button was tapped in the annotation take user to timeViewController 
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
        self.performSegue(withIdentifier: "maptoTimer", sender: nil)

        }
    //empty variable to place coordinates in 
    var locationCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    //finding the selected annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        locationCoordinate = view.annotation!.coordinate
        print("selected annotation", view.annotation as Any)
        print("selected annotation", view.annotation?.title as Any)
        print("selected annotation", view.annotation?.coordinate as Any)
        self.performSegue(withIdentifier: "maptoTimer", sender: nil)
      
    }
    //takes the coordinantes from annotation that was clicked and sends them to the variable datafrommap in timer view controller 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "maptoTimer") {
         let destVC : timerViewController = segue.destination as! timerViewController
         destVC.dataFromMap = locationCoordinate
        }
     
     }
    //pulls in the information from the timer view controller
    func userDidEnterInformation(info: String) {
        plateName = info
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
  
