//
//  SpeedViewController.swift
//  Tracker
//
//  Created by Nitesh on 1/17/15.
//  Copyright (c) 2015 Nitesh. All rights reserved.
//

import UIKit

class SpeedViewController: UIViewController, UIPickerViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var data  = ["Walking", "Running"];
    
    var lm : CLLocationManager!
    
    var trackPointArray : NSMutableArray!
    
    var speed: NSInteger!
    
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var xCoord: UILabel!
    
    
    @IBOutlet weak var yCoord: UILabel!
    
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBAction func stop(sender: AnyObject) {
        lm = CLLocationManager()
        lm.stopUpdatingLocation()
        lm = nil
        
    }
    @IBAction func startTracking(sender: AnyObject) {
        
        
        self.lm = CLLocationManager()
        self.lm.delegate = self
        self.lm.desiredAccuracy = kCLLocationAccuracyBest
        self.lm.distanceFilter = kCLDistanceFilterNone
        
        
        
        self.lm.requestWhenInUseAuthorization()
        
        
        // lm.requestAlwaysAuthorization()
        
        self.lm.startUpdatingLocation()
        
        
        
        
        println("This is working!")
        
        
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
    
    
    
    
    
    ///////////////////////////////////////////
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        println("This is working")
        var currentLocation: CLLocation = locations.last as CLLocation
        
        xCoord.text = currentLocation.coordinate.latitude.description
        yCoord.text = currentLocation.coordinate.longitude.description
        
        var sp = currentLocation.speed.description as NSString
        //  var tempSp = sp.floatValue
        var spInt: Float32 = sp.floatValue 
        
        var tempSp = abs(NSInteger(spInt))
        
        self.speed = tempSp
        
        if(self.speed? < 4){
            print("less than three")
            
            pickerView.selectedRowInComponent(0)
            
        }else{
            print("greater than three")
            pickerView.selectedRowInComponent(1)
            
        }
        
        
        
        speedLabel.text = "\(speed)" + " m/s"
        
        
        var temp : CLLocationCoordinate2D!
        temp = currentLocation.coordinate
        // temp.longitude = currentLocation.coordinate.longitude
        reverseGeocodeCoordinate(temp)
        
        var location: CLLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        // println(location)
        
        
        
        
        
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            //  println(location)
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

    
    
    
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
            trackPointArray  = NSMutableArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfRowsInComponent(component: Int) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        print("count is \(data.count)")
        return data.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        
        
      
        return data[row]
        
        
    }
    
   /* func selectRow(row: Int, inComponent component: Int, animated: Bool){
        
    }*/

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        var itemSelect = data[row]
        self.activityLabel.text = itemSelect
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
