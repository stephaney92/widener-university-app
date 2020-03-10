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


//building the pin ticker


class mapViewController: UIViewController, MKMapViewDelegate{
    
    //class so an image can be added to point annotation
    class CustomPointAnnotation: MKPointAnnotation{
        var imageName: String!
    }
    @IBOutlet weak var map: MKMapView!
    //pin names taking attributes from custom point class
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //set the map location to a specific location when the view loads
        let centerLocation = CLLocationCoordinate2DMake(39.863048 , -75.357583)
        //logingitude and latitude that the map will cover
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        //range that the map will show
        let mapRange = MKCoordinateRegion(center: centerLocation, span: mapSpan)
        //what we will see on the map
        self.map.setRegion(mapRange, animated: false)
        
        addAnnotation()
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
    }
    //funtion to create annotations
    private func addAnnotation(){
        let parkSpaceOne = MKPointAnnotation()
        let parkSpaceTwo = MKPointAnnotation()
        let db = Firestore.firestore()
     
        
       
        
       //markers on map
        /*parkSpaceOne.title = "P1"
        parkSpaceOne.coordinate = CLLocationCoordinate2D(latitude: 39.863037, longitude: -75.357542)
        map.addAnnotation(parkSpaceOne)
      
        parkSpaceTwo.title = "P2"
        parkSpaceTwo.coordinate = CLLocationCoordinate2D(latitude: 39.863149, longitude: -75.357680)
        map.addAnnotation(parkSpaceTwo)*/
        
        //grabs all the coordinates of the parking spaces in firebase
        db.collection("ParkingSpaces").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let coords = document.get("coordinate") {
                        let point = coords as! GeoPoint
                        let lat = point.latitude
                        let lon = point.longitude
                        
                        let parkspaceone = document.get("spot") as! String
                        if (parkspaceone == "p1"){
                            parkSpaceOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            self.map.addAnnotation(parkSpaceOne)
                        }
                   
                        /*if (document.get("spot") === "p1"){
                       parkSpaceOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        self.map.addAnnotation(parkSpaceOne)
                        }*/
                        
                       
                        //parkSpaceTwo.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        
                        //print(lat, lon)
                       //self.map.addAnnotation(parkSpaceTwo)
                        
                        
                       
                    
                       
                    }
                }
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

