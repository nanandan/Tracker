//
//  ViewController.swift
//  LocationTracker
//
//  Created by Nitesh on 12/22/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI


class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate  {
    
    
    
    var socketio:SRWebSocket?
    let server = "example.com"
    let session:NSURLSession?

    var lm : CLLocationManager!
    
    var trackPointArray : NSMutableArray!
    
    @IBOutlet weak var xCoord: UILabel!
    
    @IBOutlet weak var yCoord: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   

    }
    override func viewDidAppear(animated: Bool) {
        trackPointArray  = NSMutableArray()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func Start(sender: AnyObject) {

        self.lm = CLLocationManager()
        self.lm.delegate = self
        self.lm.desiredAccuracy = kCLLocationAccuracyBest
        self.lm.distanceFilter = kCLDistanceFilterNone
        
        
        
        self.lm.requestWhenInUseAuthorization()
        
        
        
        self.lm.startUpdatingLocation()
     


        
       // sendText()
        
    }
    
   ///////////////////////////////////////////////////////////////////////
    
   
  
    //////////////////////////////////////////////////////////////////////
    @IBAction func Stop(sender: AnyObject) {
        lm = CLLocationManager()
        lm.stopUpdatingLocation()
        lm = nil
        
        
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines as [String]
                self.addressLabel.text = join("\n", lines)
                
                // 4
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var currentLocation: CLLocation = locations.last as CLLocation
        
        xCoord.text = currentLocation.coordinate.latitude.description
        yCoord.text = currentLocation.coordinate.longitude.description
        
        var sp = currentLocation.speed.description as NSString
      //  var tempSp = sp.floatValue
       var spInt: Float32 = sp.floatValue * 3.6
        
        
        
        speedLabel.text = "\(spInt)"
        
        
        var temp : CLLocationCoordinate2D!
        temp = currentLocation.coordinate
        reverseGeocodeCoordinate(temp)
        
        var location: CLLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        
       
        
        
        
        
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                println("locality is \(pm.locality)")
            }
            else {
                println("Problem with the data received from geocoder")
            }
            
        })
        
        

        
    }
    
    
}

