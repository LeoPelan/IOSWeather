////
////  RootWeatherDataSource.swift
////  beginApp
////
////  Created by Léo Pelan on 30/11/2016.
////  Copyright © 2016 baptiste chene. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class RootWeatherDataSource: NSObject, UITableViewDataSource{
//    lazy var dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "fr_FR")
//        formatter.dateFormat = "EEEE d MMMM"
//        return formatter
//    }
//    
//    var resultWeather: WeatherArray?
//    
//    //Get object weather for index row
//    func getWeatherObject(forIndexRow row: Int)-> WeatherObject? {
//        guard let weathers = self.resultWeather,
//            row < weathers.count else {return nil}
//        return weathers[row]
//    }
//    
//    //fetch New Weather
//    func updateWeather(completion: @escaping (Void) -> Void) {
//        SWRequestmanager.sharedInstance.fetchWeather(onSuccess: {(result) in
//            self.resultWeather = result
//            self.reload()
//        }) {(error) in
//            print("Error => \(error)")
//        }
//    }
//}
