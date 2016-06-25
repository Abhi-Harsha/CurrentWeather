//
//  HomeVC.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/13/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeVC: UIViewController , UISearchBarDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var LocationStatusLbl: UILabel!
    @IBOutlet weak var LocSearchBar: UISearchBar!
    @IBOutlet weak var LocValLbl: UILabel!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var toggleSegControl: UISegmentedControl!
    
    var weather: Weather!
    var isLocationEnabled: BooleanType!
    
    let locationmanager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocSearchBar.delegate = self
        LocSearchBar.returnKeyType = UIReturnKeyType.Done
        locationmanager.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        LocValLbl.hidden = true
        LocationStatusLbl.hidden = true
        view.endEditing(false)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        LocValLbl.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WeatherDetails" {
            if let wDetailsVC = segue.destinationViewController as? WeatherDetailsVC {
                wDetailsVC.weather = self.weather as Weather
            }
        } else if segue.identifier == "LocationWeatherDetails" {
            if let wDetailsVC = segue.destinationViewController as? WeatherDetailsVC {
                wDetailsVC.weather = self.weather as Weather
            }
        }
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let ident = identifier {
            if ident == "WeatherDetails" {
                if ((LocSearchBar.text == nil || LocSearchBar.text == "")) {
                    LocValLbl.hidden = false
                    return false
                } else {
                    if toggleSegControl.selectedSegmentIndex == 0 {
                        weather = Weather(name: "\(LocSearchBar.text!)",isCelciusSelected: true ,isLocationAuthorized: false, latitude: 0.0,longitude: 0.0)
                    } else {
                        weather = Weather(name: "\(LocSearchBar.text!)",isCelciusSelected: false ,isLocationAuthorized: false, latitude: 0.0,longitude: 0.0)
                    }
                }
            } else if let locationident = identifier {
                if locationident == "LocationWeatherDetails" {
                    if checkForUserLocationAuthStatus() {
                        if let loc = locationmanager.location {
                            if let lat = loc.coordinate.latitude as? Double , long = loc.coordinate.longitude as? Double {
                                if toggleSegControl.selectedSegmentIndex == 0 {
                                    weather = Weather(name: "", isCelciusSelected: true, isLocationAuthorized: true, latitude: lat, longitude: long)
                                } else {
                                    weather = Weather(name: "", isCelciusSelected: false, isLocationAuthorized: true, latitude: lat, longitude: long)
                                }
                            }
                            return true
                        } else{
                            LocationStatusLbl.text = "Location status not updated! please try again after sometime"
                            LocationStatusLbl.hidden = false
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    func checkForUserLocationAuthStatus() -> BooleanType {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            return true
        } else {
            locationmanager.requestWhenInUseAuthorization()
            return false
        }
    }
    

}
