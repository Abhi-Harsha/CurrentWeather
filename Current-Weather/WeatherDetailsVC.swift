//
//  WeatherDetailsVC.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/11/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import UIKit

class WeatherDetailsVC: UIViewController {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var weatherDescpLbl: UILabel!
    @IBOutlet weak var cityCountryLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    var weather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(weather.CityName)
        weather.DownloadWeatherDetails { 
            print("download complete")
            self.updateLables()
        }
    }
    
    func updateLables() {
        if let weatherdescp = weather.WeatherDescription {
          weatherDescpLbl.text = weatherdescp
        }
        
        if let country = weather.Country {
            cityCountryLbl.text = "\(weather.CityName), \(country)"
        }
        
        if let degree = weather.CurrentTemperature {
            degreeLbl.text = "\(degree)°C"
        }
        
        if let windspeed = weather.WindSpeed {
            windSpeedLbl.text = "\(windspeed) KM\\H"
        }

    }

    @IBAction func onBackBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

