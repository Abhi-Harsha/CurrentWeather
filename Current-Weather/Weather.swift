//
//  Weather.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/11/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import Foundation

class Weather {
    private var _cityID: Int32!
    private var _cityName: String!
    private var _currentTemperature: String!
    private var _weatherMain: String!
    private var _weatherDescription: String!
    private var _country: String!
    private var _windSpeed: String!
    
    var CityID: Int32 {
        return _cityID
    }
    
    var CityName: String {
        return _cityName
    }
    
    var CurrentTemperature: String {
        return _currentTemperature
    }
    
    var Country: String {
        return _country
    }
    
    var WindSpeed: String {
        return _windSpeed
    }
    
    var WeatherMain: String {
        return _weatherMain
    }
    
    var WeatherDescription: String {
        return _weatherDescription
    }
}
