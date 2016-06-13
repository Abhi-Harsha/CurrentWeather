//
//  Constants.swift
//  Current-Weather
//
//  Created by Abhishek H P on 6/11/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q="
let API_KEY = "3a1fb24814c95d9ddd8d216624be7be2"

typealias DownloadCompleted = () -> ()

//by id
//api.openweathermap.org/data/2.5/weather?id=1277333&APPID=3a1fb24814c95d9ddd8d216624be7be2

//by name
//api.openweathermap.org/data/2.5/weather?q=London&APPID=3a1fb24814c95d9ddd8d216624be7be2

//For temperature in Celsius use units=metric
//api.openweathermap.org/data/2.5/find?q=London&units=metric&APPID=3a1fb24814c95d9ddd8d216624be7be2