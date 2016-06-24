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
    @IBOutlet weak var HumidityLabl: UILabel!
    var weather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        weather.DownloadWeatherDetails {
            print("download complete")
            self.updateLables()
        }
    }
    
    func updateLables() {
            if let weatherdescp = weather.WeatherDescription {
                weatherDescpLbl.text = weatherdescp
                if weatherdescp.containsString("Rain") || weatherdescp.containsString("Drizzle") {
                    weatherIcon.image = UIImage(named: "rainyhollow.png")
                } else if weatherdescp.containsString("Cloud") {
                    weatherIcon.image = UIImage(named: "cloudydark.png")
                } else if weatherdescp.containsString("Sun") || weatherdescp.containsString("Sky") {
                    weatherIcon.image = UIImage(named: "sunny.png")
                } else if weatherdescp.containsString("Snow") {
                    weatherIcon.image = UIImage(named: "snow-1.png")
                }
            }
            
            if let country = weather.Country {
                if let name = weather.CityName {
                    cityCountryLbl.text = "\(name), \(country)"
                }
            }
        
        
            if weather.CelciusSelected {
                if let degree = weather.CurrentTemperature {
                    degreeLbl.text = "\(degree)°C"
                }
            } else {
                if let degree = weather.CurrentTemperature {
                    degreeLbl.text = "\(degree)°F"
                }
            }
        
            
            if let windspeed = weather.WindSpeed {
                windSpeedLbl.text = "\(windspeed) KM/H"
            }
        
            if let humidity = weather.Humidity {
                HumidityLabl.text = humidity
            }
    }

    @IBAction func onBackBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

