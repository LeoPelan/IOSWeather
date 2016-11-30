//
//  SWRequestManager.swift
//  beginApp
//
//  Created by Léo Pelan on 02/11/2016.
//  Copyright © 2016  Léo Pelan. All rights reserved.
//

import Foundation
import Alamofire

// Request Manager to make HTPP Calls to weather server

typealias WeatherObject = Dictionary<String, AnyObject>
typealias WeatherArray = Array<WeatherObject>
class SWRequestmanager{
    
    static let sharedInstance = SWRequestmanager()
    private let apiKey = "529bdcc9be6e50cf50574aa357fa7cb7"
    private let host = "https://api.darksky.net/forecast/"
    public var actualCoordinate : (latitude: String, longitude: String)
    
    private init() {
        actualCoordinate = (latitude: "48.8839", longitude: "2.3509")
    }
    func fetchWeather(onSuccess success: @escaping (WeatherArray) -> Void, onError error : @escaping (String) ->Void) {
        
        var strRequest = "\(host)\(apiKey)/"
        strRequest += "\(actualCoordinate.latitude),\(actualCoordinate.longitude)"
        strRequest += "?lang=fr&units=si"
    Alamofire.request(strRequest).responseJSON { response in
    
    guard let JSON = response.result.value as? Dictionary<String, Any> else{
//    print("JSON: \(JSON)")
        error("No Data")
        return
    }
        guard let daily = JSON["daily"] as? Dictionary<String, Any>, let data = daily["data"] as? Array<Dictionary<String, Any>> else {
            error("Request Manager -> \(strRequest)")
            return
        }
        success(data as WeatherArray)
        }
    }
}
