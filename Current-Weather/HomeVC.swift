//
//  HomeVC.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/13/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController , UISearchBarDelegate{

    @IBOutlet weak var LocSearchBar: UISearchBar!
    @IBOutlet weak var LocValLbl: UILabel!
    var weather: Weather!
    let locationmanager = CLLocationManager()
    
    @IBOutlet weak var toggleSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocSearchBar.delegate = self
        LocSearchBar.returnKeyType = UIReturnKeyType.Done

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        LocValLbl.hidden = true
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
                        weather = Weather(name: "\(LocSearchBar.text!)",isCelciusSelected: true ,isLocationAuthorized: false)
                    } else {
                        weather = Weather(name: "\(LocSearchBar.text!)",isCelciusSelected: false ,isLocationAuthorized: false)
                    }
                }
            } else if let locationident = identifier {
                if locationident == "LocationWeatherDetails" {
                    if checkForUserLocationAuthStatus() {
                        print(locationmanager.location?.coordinate.latitude)
                        print(locationmanager.location?.coordinate.longitude)
                           return true
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
