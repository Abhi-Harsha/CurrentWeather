//
//  Weather.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/11/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import Foundation
import Alamofire

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

    private var _encodedURL: String!
    //api.openweathermap.org/data/2.5/find?q=London&units=metric&APPID=3a1fb24814c95d9ddd8d216624be7be2
    
    
    init(name: String?) {
        if let cityname = name {
            self._cityName = cityname
        }
        _weatherURL = "\(BASE_URL)\(_cityName)&units=metric&APPID=\(API_KEY)"
        _encodedURL = _weatherURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    }
    
    var CityID: Int32? {
        return _cityID
    }
    
    var CityName: String {
        return _cityName
    }
    
    var CurrentTemperature: String? {
        return _currentTemperature
    }
    
    var Country: String? {
        return _country
    }
    
    var WindSpeed: String? {
        return _windSpeed
    }
    
    var WeatherMain: String? {
        return _weatherMain
    }
    
    var WeatherDescription: String? {
        return _weatherDescription
    }
    
    var Humidity: String? {
        return _humidity
    }

    
    func DownloadWeatherDetails(completed: DownloadCompleted) {
        let url = NSURL(string: "\(_encodedURL)")
        
        
        Alamofire.request(.GET, url!).responseJSON { (reponse: Response<AnyObject, NSError>) in
        
            print(reponse.debugDescription)
            if let weatherDictonary = reponse.result.value as? Dictionary<String, AnyObject> {
                print(weatherDictonary.debugDescription)
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
