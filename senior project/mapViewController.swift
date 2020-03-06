//
//  mapViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 2/18/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit
import MapKit


//building the pin ticker


class mapViewController: UIViewController, MKMapViewDelegate{
    
    //class so an image can be added to point annotation
    class CustomPointAnnotation: MKPointAnnotation{
        var imageName: String!
    }
    @IBOutlet weak var map: MKMapView!
    //pin names taking attributes from custom point class
    var parkSpaceOne = CustomPointAnnotation()
    var parkSpaceTwo = CustomPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //set the map location to a specific location when the view loads
        let centerLocation = CLLocationCoordinate2DMake(39.863048 , -75.357583)
        //logingitude and latitude that the map will cover
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.00001, longitudeDelta: 0.00001)
        //range that the map will show
        let mapRange = MKCoordinateRegion(center: centerLocation, span: mapSpan)
        //what we will see on the map
        self.map.setRegion(mapRange, animated: false)
        
        addAnnotation()
        map.delegate = self
    }
    //funtion to create annotations
    private func addAnnotation(){
        parkSpaceOne.title = "P1"
        parkSpaceOne.coordinate = CLLocationCoordinate2D(latitude: 39.863037, longitude: -75.357542)
        map.addAnnotation(parkSpaceOne)
        
        parkSpaceTwo.title = "P2"
        parkSpaceTwo.coordinate = CLLocationCoordinate2D(latitude: 39.863149, longitude: -75.357680)
        map.addAnnotation(parkSpaceTwo)
        }
    }
    //CHANGE THIS CODE IT DOES NOT WORK 
   //implement mkviewmap protocol, offers methods to customize map
    //customize annotation images 
    extension ViewController: MKMapViewDelegate{
        //gives back a map view and an annotation
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
            //injectecting annotation view here and retuning it back
            if annotationView == nil{
                //mkannotationview proivides a lot in the API
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
            }
            if annotation.title == "P1"{
                annotationView?.image = UIImage(named: "redticker")
            }
            else if annotation.title == "P2"{
                annotationView?.image = UIImage(named: "greenticker")
            }
            //when tapping on annotion the bubble appears stating the name of the point annotation
            annotationView?.canShowCallout = true
            
            
            return annotationView
        }
        private func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
            print("the annotation was selected: ")
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

