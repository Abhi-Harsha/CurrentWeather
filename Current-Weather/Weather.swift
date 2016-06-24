//
//  Weather.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/11/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class Weather {
    private var _cityID: Int32!
    private var _cityName: String!
    private var _currentTemperature: String!
    private var _weatherMain: String!
    private var _weatherDescription: String!
    private var _country: String!
    private var _windSpeed: String!
    private var _humidity: String!
    private var _weatherURL: String!
    private var _isCelciusSelected: BooleanType!
    private var _latitude: Double!
    private var _longitude: Double!

    private var _encodedURL: String!
    //api.openweathermap.org/data/2.5/find?q=London&units=metric&APPID=3a1fb24814c95d9ddd8d216624be7be2
    //http://api.openweathermap.org/data/2.5/weather?lat=12.89679948996003&lon=77.548581512844706&units=metric&APPID=3a1fb24814c95d9ddd8d216624be7be2
    
    
    init(name: String?, isCelciusSelected: BooleanType, isLocationAuthorized: BooleanType, latitude: Double?, longitude: Double?) {
        if let cityname = name where cityname != ""{
            self._cityName = cityname
            if isCelciusSelected {
                self._isCelciusSelected = isCelciusSelected
                _weatherURL = "\(BASE_URL)?q=\(_cityName)&units=metric&APPID=\(API_KEY)"
                _encodedURL = _weatherURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            } else {
                self._isCelciusSelected = isCelciusSelected
                _weatherURL = "\(BASE_URL)?&q=\(_cityName)&units=fahrenheit&APPID=\(API_KEY)"
                _encodedURL = _weatherURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            }
        }
        
        if isLocationAuthorized {
            if let lat = latitude , long = longitude  {
                self._latitude = lat
                self._longitude = long
                if isCelciusSelected{
                    self._isCelciusSelected = isCelciusSelected
                    _weatherURL = "\(BASE_URL)?lat=\(_latitude)&lon=\(_longitude)&units=metric&APPID=\(API_KEY)"
                    _encodedURL = _weatherURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                } else {
                    self._isCelciusSelected = isCelciusSelected
                    _weatherURL = "\(BASE_URL)?lat=\(_latitude)&lon=\(_longitude)&units=fahrenheit&APPID=\(API_KEY)"
                    _encodedURL = _weatherURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                }
            }
        }
    }
    
    var CityID: Int32? {
        return _cityID
    }
    
    var CityName: String? {
        if let name = _cityName {
            return name
        }
        return ""
    }
    
    var CurrentTemperature: String? {
        if let temp = _currentTemperature {
            return temp
        }
        return ""
    }
    
    var Country: String? {
        if let country = _country {
            return country
        }
        return ""
    }
    
    var WindSpeed: String? {
        if let speed = _windSpeed {
            return speed
        }
        return ""
    }
    
    var WeatherMain: String? {
        if let weathermain = _weatherMain {
            return weathermain
        }
        return ""
    }
    
    var WeatherDescription: String? {
        if let weatherdescp = _weatherDescription {
            return weatherdescp
        }
        return ""
    }
    
    var Humidity: String? {
        if let humid = _humidity {
            return humid
        }
        return ""
    }
    
    var CelciusSelected: BooleanType {
        return _isCelciusSelected
    }

    
    func DownloadWeatherDetails(completed: DownloadCompleted) {
        let url = NSURL(string: "\(_encodedURL)")
        
        
        Alamofire.request(.GET, url!).responseJSON { (reponse: Response<AnyObject, NSError>) in
        
            print(reponse.debugDescription)
            if let weatherDictonary = reponse.result.value as? Dictionary<String, AnyObject> {
                print(weatherDictonary.debugDescription)
                
                //city name
                if let name = weatherDictonary["name"] as? String {
                    self._cityName = name
                }
                //_currentTemp
                if let weathermain = weatherDictonary["main"] as? Dictionary<String, AnyObject> {
                    if let temp = weathermain["temp"] as? Float {
                        self._currentTemperature = "\(temp)"
                        print(self._currentTemperature)
                    }
                    
                    if let humidity = weathermain["humidity"] as? Int {
                        self._humidity = "\(humidity)"
                    }
                }
                //weatherDescription
                if let weather = weatherDictonary["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                    if let description = weather[0]["description"] as? String  {
                        self._weatherDescription = description.capitalizedString
                        print(self._weatherDescription)
                    }
                }
                
                //windSpeed
                if let wind = weatherDictonary["wind"] as? Dictionary<String, AnyObject> {
                    if let windspeed = wind["speed"] as? Float {
                        self._windSpeed = "\(windspeed)"
                        print(self._windSpeed)
                    }
                }
                
                //country
                if let sys = weatherDictonary["sys"] as? Dictionary<String, AnyObject> {
                    if let country = sys["country"] as? String {
                       self._country = country
                        print(self._country)
                    }
                }
            }
        completed()
        }
    }
}
