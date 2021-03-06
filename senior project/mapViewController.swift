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
        
        navigationItem.hidesBackButton = true;
        
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
            //let parkSpaceOne = CustomPointAnnotation()
            let parkSpaceTwo = CustomPointAnnotation()
            let parkSpaceThree = CustomPointAnnotation()
            let parkSpaceEight = CustomPointAnnotation()
            let parkSpaceFifteen = CustomPointAnnotation()
            //let parkSpaceTwentyTwo = CustomPointAnnotation()
            let parkSpaceTwentyFour = CustomPointAnnotation()
            //let parkSpaceThirtyOne = CustomPointAnnotation()
            let parkSpaceThirtyThree = CustomPointAnnotation()
            let parkSpaceForty = CustomPointAnnotation()
            let parkSpaceFortyFour = CustomPointAnnotation()
            let parkSpaceFortyNine = CustomPointAnnotation()
            let parkSpaceFiftyOne = CustomPointAnnotation()
            let parkSpaceFiftyFive = CustomPointAnnotation()
            let parkSpaceSixty = CustomPointAnnotation()
            let parkSpaceSixtySix = CustomPointAnnotation()
            let parkSpaceSixtyNine = CustomPointAnnotation()
            let parkSpaceSeventyFour = CustomPointAnnotation()
            let parkSpaceEightyOne = CustomPointAnnotation()
            let parkSpaceEightyThree = CustomPointAnnotation()
            let parkSpaceEightyEight = CustomPointAnnotation()
            let parkSpaceNinetyThree = CustomPointAnnotation()
            //let parkSpaceOneHundred = CustomPointAnnotation()
            let parkSpaceOneHundredFourteen = CustomPointAnnotation()
            let parkSpaceOneHundredSeventeen = CustomPointAnnotation()
            let parkSpaceOneHundredEighteen = CustomPointAnnotation()
            let parkSpaceOneHundredTwentyTwo = CustomPointAnnotation()
            //let parkSpaceOneHundredTwentyFive = CustomPointAnnotation()
            //let parkSpaceOneHundredTwentySix = CustomPointAnnotation()
            let parkSpaceOneHundredTwentyNine = CustomPointAnnotation()
            //let parkSpaceOneHundredThirtyThree = CustomPointAnnotation()
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
                                //let spotpone = document.get("spot") as! String
                                let spotptwo = document.get("spot") as! String
                                let spotpthree = document.get("spot") as! String
                                let spotpeight = document.get("spot") as! String
                                let spotpfifteen = document.get("spot") as! String
                                //let spotptwentytwo = document.get("spot") as! String
                                let spotptwentyfour = document.get("spot") as! String
                                //let spotpthirtyone = document.get("spot") as! String
                                let spotpthirtythree = document.get("spot") as! String
                                let spotpforty = document.get("spot") as! String
                                let spotpfortyfour = document.get("spot") as! String
                                let spotpfortynine = document.get("spot") as! String
                                let spotpfiftyone = document.get("spot") as! String
                                let spotpfiftyfive = document.get("spot") as! String
                                let spotpsixty = document.get("spot") as! String
                                let spotpsixtysix = document.get("spot") as! String
                                let spotpsixtynine = document.get("spot") as! String
                                let spotpseventyfour = document.get("spot") as! String
                                let spotpeightyone = document.get("spot") as! String
                                let spotpeightythree = document.get("spot") as! String
                                let spotpeightyeight = document.get("spot") as! String
                                let spotpninetythree = document.get("spot") as! String
                                //let spotponehundred = document.get("spot") as! String
                                let spotponehundredfourteen = document.get("spot") as! String
                                let spotponehundredseventeen = document.get("spot") as! String
                                let spotponehundredeighteen = document.get("spot") as! String
                                let spotponehundredtwentytwo = document.get("spot") as! String
                                //let spotponehundredtwentyfive = document.get("spot") as! String
                                //let spotponehundredtwentysix = document.get("spot") as! String
                                let spotponehundredtwentynine = document.get("spot") as! String
                                //let spotponehundredthirtythree = document.get("spot") as! String
                                
                                //boolean variable for spot availability in firebase
                                //let spotOneAvailability = document.get("spaceAvailability") as! Bool
                                let spotTwoAvailability = document.get("spaceAvailability") as! Bool
                                let spotThreeAvailability = document.get("spaceAvailability") as! Bool
                                let spotEightAvailability = document.get("spaceAvailability") as! Bool
                                let spotFifteenAvailability = document.get("spaceAvailability") as! Bool
                                //let spotTwentyTwoAvailability = document.get("spaceAvailability") as! Bool
                                let spotTwentyFourAvailability = document.get("spaceAvailability") as! Bool
                                //let spotThirtyOneAvailability = document.get("spaceAvailability") as! Bool
                                let spotThirtyThreeAvailability = document.get("spaceAvailability") as! Bool
                                let spotFortyAvailability = document.get("spaceAvailability") as! Bool
                                let spotFortyFourAvailability = document.get("spaceAvailability") as! Bool
                                let spotFortyNineAvailability = document.get("spaceAvailability") as! Bool
                                let spotFiftyOneAvailability = document.get("spaceAvailability") as! Bool
                                let spotFiftyFiveAvailability = document.get("spaceAvailability") as! Bool
                                let spotSixtyAvailability = document.get("spaceAvailability") as! Bool
                                let spotSixtySixAvailability = document.get("spaceAvailability") as! Bool
                                let spotSixtyNineAvailability = document.get("spaceAvailability") as! Bool
                                let spotSeventyFourAvailability = document.get("spaceAvailability") as! Bool
                                let spotEightyOneAvailability = document.get("spaceAvailability") as! Bool
                                let spotEightyThreeAvailability = document.get("spaceAvailability") as! Bool
                                let spotEightyEightAvailability = document.get("spaceAvailability") as! Bool
                                let spotNinetyThreeAvailability = document.get("spaceAvailability") as! Bool
                                //let spotOneHundredAvailability = document.get("spaceAvailability") as! Bool
                                let spotOneHundredFourteenAvailability = document.get("spaceAvailability") as! Bool
                                let spotOneHundredSeventeenAvailability = document.get("spaceAvailability") as! Bool
                                let spotOneHundredEighteenAvailability = document.get("spaceAvailability") as! Bool
                                let spotOneHundredTwentyTwoAvailability = document.get("spaceAvailability") as! Bool
                                //let spotOneHundredTwentyFiveAvailability = document.get("spaceAvailability") as! Bool
                                //let spotOneHundredTwentySixAvailability = document.get("spaceAvailability") as! Bool
                                let spotOneHundredTwentyNineAvailability = document.get("spaceAvailability") as! Bool
                                //let spotOneHundredThirtyThreeAvailability = document.get("spaceAvailability") as! Bool

                                
                                //if the spot in firbase matches the string then take the coordinates, add them to an annotation and place on the map
                                /*if (spotpone == "p1"){
                                    parkSpaceOne.title = "P1"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOne.subtitle = self.plateName
                                    parkSpaceOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOne.imageName = "greenticker"

                                    if (spotOneAvailability == false) {
                                        parkSpaceOne.imageName = "redticker"
                                    }
                                    else if (spotOneAvailability == true) {
                                        parkSpaceOne.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOne)
                                    points.append(parkSpaceOne)
                                    

                                }*/
                                if (spotptwo == "p2"){
                                    parkSpaceTwo.title = "P2"
                                    parkSpaceTwo.subtitle = self.plateName
                                    parkSpaceTwo.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceTwo.imageName = "greenticker"

                                    if (spotTwoAvailability == false) {
                                        parkSpaceTwo.imageName = "redticker"
                                    }
                                    else if (spotTwoAvailability == true) {
                                        parkSpaceTwo.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceTwo)
                                    points.append(parkSpaceTwo)
                                    

                                }
                                else if (spotpthree == "p3"){
                                    parkSpaceThree.title = "P3"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceThree.subtitle = self.plateName
                                    parkSpaceThree.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceThree.imageName = "greenticker"

                                    if (spotThreeAvailability == false) {
                                        parkSpaceThree.imageName = "redticker"
                                    }
                                    else if (spotThreeAvailability == true) {
                                        parkSpaceThree.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceThree)
                                    points.append(parkSpaceThree)
                                }
                                else if (spotpeight == "p8"){
                                    parkSpaceEight.title = "P8"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceEight.subtitle = self.plateName
                                    parkSpaceEight.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceEight.imageName = "greenticker"

                                    if (spotEightAvailability == false) {
                                        parkSpaceEight.imageName = "redticker"
                                    }
                                    else if (spotEightAvailability == true) {
                                        parkSpaceEight.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceEight)
                                    points.append(parkSpaceEight)
                                }
                                else if (spotpfifteen == "p15"){
                                    parkSpaceFifteen.title = "P15"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceFifteen.subtitle = self.plateName
                                    parkSpaceFifteen.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceFifteen.imageName = "greenticker"

                                    if (spotFifteenAvailability == false) {
                                        parkSpaceFifteen.imageName = "redticker"
                                    }
                                    else if (spotFifteenAvailability == true) {
                                        parkSpaceFifteen.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceFifteen)
                                    points.append(parkSpaceFifteen)
                                }
                                /*else if (spotptwentytwo == "p22"){
                                    parkSpaceTwentyTwo.title = "P22"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceTwentyTwo.subtitle = self.plateName
                                    parkSpaceTwentyTwo.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceTwentyTwo.imageName = "greenticker"

                                    if (spotTwentyTwoAvailability == false) {
                                        parkSpaceTwentyTwo.imageName = "redticker"
                                    }
                                    else if (spotTwentyTwoAvailability == true) {
                                        parkSpaceTwentyTwo.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceTwentyTwo)
                                    points.append(parkSpaceTwentyTwo)
                                }*/
                                else if (spotptwentyfour == "p24"){
                                    parkSpaceTwentyFour.title = "P24"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceTwentyFour.subtitle = self.plateName
                                    parkSpaceTwentyFour.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceTwentyFour.imageName = "greenticker"

                                    if (spotTwentyFourAvailability == false) {
                                        parkSpaceTwentyFour.imageName = "redticker"
                                    }
                                    else if (spotTwentyFourAvailability == true) {
                                        parkSpaceTwentyFour.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceTwentyFour)
                                    points.append(parkSpaceTwentyFour)
                                }
                                /*else if (spotpthirtyone == "p31"){
                                    parkSpaceThirtyOne.title = "P31"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceThirtyOne.subtitle = self.plateName
                                    parkSpaceThirtyOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceThirtyOne.imageName = "greenticker"

                                    if (spotThirtyOneAvailability == false) {
                                        parkSpaceThirtyOne.imageName = "redticker"
                                    }
                                    else if (spotThirtyOneAvailability == true) {
                                        parkSpaceThirtyOne.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceThirtyOne)
                                    points.append(parkSpaceThirtyOne)
                                }*/
                                else if (spotpthirtythree == "p33"){
                                    parkSpaceThirtyThree.title = "P33"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceThirtyThree.subtitle = self.plateName
                                    parkSpaceThirtyThree.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceThirtyThree.imageName = "greenticker"

                                    if (spotThirtyThreeAvailability == false) {
                                        parkSpaceThirtyThree.imageName = "redticker"
                                    }
                                    else if (spotThirtyThreeAvailability == true) {
                                        parkSpaceThirtyThree.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceThirtyThree)
                                    points.append(parkSpaceThirtyThree)
                                }
                                else if (spotpforty == "p40"){
                                    parkSpaceForty.title = "P40"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceForty.subtitle = self.plateName
                                    parkSpaceForty.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceForty.imageName = "greenticker"

                                    if (spotFortyAvailability == false) {
                                        parkSpaceForty.imageName = "redticker"
                                    }
                                    else if (spotFortyAvailability == true) {
                                        parkSpaceForty.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceForty)
                                    points.append(parkSpaceForty)
                                }
                                else if (spotpfortyfour == "p44"){
                                    parkSpaceFortyFour.title = "P44"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceFortyFour.subtitle = self.plateName
                                    parkSpaceFortyFour.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceFortyFour.imageName = "greenticker"

                                    if (spotFortyFourAvailability == false) {
                                        parkSpaceFortyFour.imageName = "redticker"
                                    }
                                    else if (spotFortyFourAvailability == true) {
                                        parkSpaceFortyFour.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceFortyFour)
                                    points.append(parkSpaceFortyFour)
                                }
                                else if (spotpfortynine == "p49"){
                                    parkSpaceFortyNine.title = "P49"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceFortyNine.subtitle = self.plateName
                                    parkSpaceFortyNine.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceFortyNine.imageName = "greenticker"

                                    if (spotFortyNineAvailability == false) {
                                        parkSpaceFortyNine.imageName = "redticker"
                                    }
                                    else if (spotFortyNineAvailability == true) {
                                        parkSpaceFortyNine.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceFortyNine)
                                    points.append(parkSpaceFortyNine)
                                }
                                else if (spotpfiftyone == "p51"){
                                    parkSpaceFiftyOne.title = "P51"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceFiftyOne.subtitle = self.plateName
                                    parkSpaceFiftyOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceFiftyOne.imageName = "greenticker"

                                    if (spotFiftyOneAvailability == false) {
                                        parkSpaceFiftyOne.imageName = "redticker"
                                    }
                                    else if (spotFiftyOneAvailability == true) {
                                        parkSpaceFiftyOne.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceFiftyOne)
                                    points.append(parkSpaceFiftyOne)
                                }
                                else if (spotpfiftyfive == "p55"){
                                    parkSpaceFiftyFive.title = "P55"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceFiftyFive.subtitle = self.plateName
                                    parkSpaceFiftyFive.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceFiftyFive.imageName = "greenticker"

                                    if (spotFiftyFiveAvailability == false) {
                                        parkSpaceFiftyFive.imageName = "redticker"
                                    }
                                    else if (spotFiftyFiveAvailability == true) {
                                        parkSpaceFiftyFive.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceFiftyFive)
                                    points.append(parkSpaceFiftyFive)
                                }
                                else if (spotpsixty == "p60"){
                                    parkSpaceSixty.title = "P60"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceSixty.subtitle = self.plateName
                                    parkSpaceSixty.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceSixty.imageName = "greenticker"

                                    if (spotSixtyAvailability == false) {
                                        parkSpaceSixty.imageName = "redticker"
                                    }
                                    else if (spotSixtyAvailability == true) {
                                        parkSpaceSixty.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceSixty)
                                    points.append(parkSpaceSixty)
                                }
                                else if (spotpsixtysix == "p66"){
                                    parkSpaceSixtySix.title = "P66"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceSixtySix.subtitle = self.plateName
                                    parkSpaceSixtySix.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceSixtySix.imageName = "greenticker"

                                    if (spotSixtySixAvailability == false) {
                                        parkSpaceSixtySix.imageName = "redticker"
                                    }
                                    else if (spotSixtySixAvailability == true) {
                                        parkSpaceSixtySix.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceSixtySix)
                                    points.append(parkSpaceSixtySix)
                                }
                                else if (spotpsixtynine == "p69"){
                                    parkSpaceSixtyNine.title = "P69"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceSixtyNine.subtitle = self.plateName
                                    parkSpaceSixtyNine.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceSixtyNine.imageName = "greenticker"

                                    if (spotSixtyNineAvailability == false) {
                                        parkSpaceSixtyNine.imageName = "redticker"
                                    }
                                    else if (spotSixtyNineAvailability == true) {
                                        parkSpaceSixtyNine.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceSixtyNine)
                                    points.append(parkSpaceSixtyNine)
                                }
                                else if (spotpseventyfour == "p74"){
                                    parkSpaceSeventyFour.title = "P74"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceSeventyFour.subtitle = self.plateName
                                    parkSpaceSeventyFour.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceSeventyFour.imageName = "greenticker"

                                    if (spotSeventyFourAvailability == false) {
                                        parkSpaceSeventyFour.imageName = "redticker"
                                    }
                                    else if (spotSeventyFourAvailability == true) {
                                        parkSpaceSeventyFour.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceSeventyFour)
                                    points.append(parkSpaceSeventyFour)
                                }
                                else if (spotpeightyone == "p81"){
                                    parkSpaceEightyOne.title = "P81"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceEightyOne.subtitle = self.plateName
                                    parkSpaceEightyOne.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceEightyOne.imageName = "greenticker"

                                    if (spotEightyOneAvailability == false) {
                                        parkSpaceEightyOne.imageName = "redticker"
                                    }
                                    else if (spotEightyOneAvailability == true) {
                                        parkSpaceEightyOne.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceEightyOne)
                                    points.append(parkSpaceEightyOne)
                                }
                                else if (spotpeightythree == "p83"){
                                    parkSpaceEightyThree.title = "P83"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceEightyThree.subtitle = self.plateName
                                    parkSpaceEightyThree.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceEightyThree.imageName = "greenticker"

                                    if (spotEightyThreeAvailability == false) {
                                        parkSpaceEightyThree.imageName = "redticker"
                                    }
                                    else if (spotEightyThreeAvailability == true) {
                                        parkSpaceEightyThree.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceEightyThree)
                                    points.append(parkSpaceEightyThree)
                                }
                                else if (spotpeightyeight == "p88"){
                                    parkSpaceEightyEight.title = "P88"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceEightyEight.subtitle = self.plateName
                                    parkSpaceEightyEight.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceEightyEight.imageName = "greenticker"

                                    if (spotEightyEightAvailability == false) {
                                        parkSpaceEightyEight.imageName = "redticker"
                                    }
                                    else if (spotEightyEightAvailability == true) {
                                        parkSpaceEightyEight.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceEightyEight)
                                    points.append(parkSpaceEightyEight)
                                }
                                else if (spotpninetythree == "p93"){
                                    parkSpaceNinetyThree.title = "P93"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceNinetyThree.subtitle = self.plateName
                                    parkSpaceNinetyThree.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceNinetyThree.imageName = "greenticker"

                                    if (spotNinetyThreeAvailability == false) {
                                        parkSpaceNinetyThree.imageName = "redticker"
                                    }
                                    else if (spotNinetyThreeAvailability == true) {
                                        parkSpaceNinetyThree.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceNinetyThree)
                                    points.append(parkSpaceNinetyThree)
                                }
                                /*else if (spotponehundred == "p100"){
                                    parkSpaceOneHundred.title = "P100"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundred.subtitle = self.plateName
                                    parkSpaceOneHundred.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundred.imageName = "greenticker"

                                    if (spotOneHundredAvailability == false) {
                                        parkSpaceOneHundred.imageName = "redticker"
                                    }
                                    else if (spotOneHundredAvailability == true) {
                                        parkSpaceOneHundred.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundred)
                                    points.append(parkSpaceOneHundred)
                                }*/
                                else if (spotponehundredfourteen == "p114"){
                                    parkSpaceOneHundredFourteen.title = "P114"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredFourteen.subtitle = self.plateName
                                    parkSpaceOneHundredFourteen.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredFourteen.imageName = "greenticker"

                                    if (spotOneHundredFourteenAvailability == false) {
                                        parkSpaceOneHundredFourteen.imageName = "redticker"
                                    }
                                    else if (spotOneHundredFourteenAvailability == true) {
                                        parkSpaceOneHundredFourteen.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredFourteen)
                                    points.append(parkSpaceOneHundredFourteen)
                                }
                                else if (spotponehundredseventeen == "p117"){
                                    parkSpaceOneHundredSeventeen.title = "P117"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredSeventeen.subtitle = self.plateName
                                    parkSpaceOneHundredSeventeen.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredSeventeen.imageName = "greenticker"

                                    if (spotOneHundredSeventeenAvailability == false) {
                                        parkSpaceOneHundredSeventeen.imageName = "redticker"
                                    }
                                    else if (spotOneHundredSeventeenAvailability == true) {
                                        parkSpaceOneHundredSeventeen.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredSeventeen)
                                    points.append(parkSpaceOneHundredSeventeen)
                                }
                                else if (spotponehundredeighteen == "p118"){
                                    parkSpaceOneHundredEighteen.title = "P118"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredEighteen.subtitle = self.plateName
                                    parkSpaceOneHundredEighteen.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredEighteen.imageName = "greenticker"

                                    if (spotOneHundredEighteenAvailability == false) {
                                        parkSpaceOneHundredEighteen.imageName = "redticker"
                                    }
                                    else if (spotOneHundredEighteenAvailability == true) {
                                        parkSpaceOneHundredEighteen.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredEighteen)
                                    points.append(parkSpaceOneHundredEighteen)
                                }
                                else if (spotponehundredtwentytwo == "p122"){
                                    parkSpaceOneHundredTwentyTwo.title = "P122"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredTwentyTwo.subtitle = self.plateName
                                    parkSpaceOneHundredTwentyTwo.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredTwentyTwo.imageName = "greenticker"

                                    if (spotOneHundredTwentyTwoAvailability == false) {
                                        parkSpaceOneHundredTwentyTwo.imageName = "redticker"
                                    }
                                    else if (spotOneHundredTwentyTwoAvailability == true) {
                                        parkSpaceOneHundredTwentyTwo.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredTwentyTwo)
                                    points.append(parkSpaceOneHundredTwentyTwo)
                                }
                                /*else if (spotponehundredtwentyfive == "p125"){
                                    parkSpaceOneHundredTwentyFive.title = "P125"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredTwentyFive.subtitle = self.plateName
                                    parkSpaceOneHundredTwentyFive.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredTwentyFive.imageName = "greenticker"

                                    if (spotOneHundredTwentyFiveAvailability == false) {
                                        parkSpaceOneHundredTwentyFive.imageName = "redticker"
                                    }
                                    else if (spotOneHundredTwentyFiveAvailability == true) {
                                        parkSpaceOneHundredTwentyFive.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredTwentyFive)
                                    points.append(parkSpaceOneHundredTwentyFive)
                                }
                                else if (spotponehundredtwentysix == "p126"){
                                    parkSpaceOneHundredTwentySix.title = "P126"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredTwentySix.subtitle = self.plateName
                                    parkSpaceOneHundredTwentySix.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredTwentySix.imageName = "greenticker"

                                    if (spotOneHundredTwentySixAvailability == false) {
                                        parkSpaceOneHundredTwentySix.imageName = "redticker"
                                    }
                                    else if (spotOneHundredTwentySixAvailability == true) {
                                        parkSpaceOneHundredTwentySix.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredTwentySix)
                                    points.append(parkSpaceOneHundredTwentySix)
                                }*/
                                else if (spotponehundredtwentynine == "p129"){
                                    parkSpaceOneHundredTwentyNine.title = "P129"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredTwentyNine.subtitle = self.plateName
                                    parkSpaceOneHundredTwentyNine.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredTwentyNine.imageName = "greenticker"

                                    if (spotOneHundredTwentyNineAvailability == false) {
                                        parkSpaceOneHundredTwentyNine.imageName = "redticker"
                                    }
                                    else if (spotOneHundredTwentyNineAvailability == true) {
                                        parkSpaceOneHundredTwentyNine.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredTwentyNine)
                                    points.append(parkSpaceOneHundredTwentyNine)
                                }
                                /*else if (spotponehundredthirtythree == "p133"){
                                    parkSpaceOneHundredThirtyThree.title = "P133"
                                    //PLACE HERE if statement if boolean true then is occupied else is availible
                                    parkSpaceOneHundredThirtyThree.subtitle = self.plateName
                                    parkSpaceOneHundredThirtyThree.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    //parkSpaceOneHundredThirtyThree.imageName = "greenticker"

                                    if (spotOneHundredThirtyThreeAvailability == false) {
                                        parkSpaceOneHundredThirtyThree.imageName = "redticker"
                                    }
                                    else if (spotOneHundredThirtyThreeAvailability == true) {
                                        parkSpaceOneHundredThirtyThree.imageName = "greenticker"
                                    }

                                    //self.map.addAnnotation(parkSpaceOneHundredThirtyThree)
                                    points.append(parkSpaceOneHundredThirtyThree)
                                }*/
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
    
    //refreshes the map page
    @IBAction func refreshPressed(_ sender: Any) {
        viewDidLoad()
    }
    //logging out users
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            //pops all the views off the stack and sends the user to the homepage
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
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
  
