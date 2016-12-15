//
//  DetailViewController.swift
//  beginApp
//
//  Created by Léo Pelan on 26/10/2016.
//  Copyright © 2016 Léo Pelan. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    @IBOutlet var LabelDetail: UILabel!
    @IBOutlet var WeatherImage: UIImageView!
    @IBOutlet var LabelTemperature: UILabel!
    @IBOutlet var LabelPrecip: UILabel!
    @IBOutlet var LabelSun: UILabel!
    @IBOutlet var SunImage: UIImageView!
    
    var resultWeather : WeatherObject?
    
    let identifier = "SegueDetail"
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "weather.png")!)
        
        SunImage.image = UIImage(named: "sunset.png");

        super.viewDidLoad()
        
        //Get all data from resultWeather JSON Array
        let tempMax = resultWeather!["temperatureMax"]!
        let tempMin = resultWeather!["temperatureMin"]!
        let precip = resultWeather!["precipProbability"]!
        let timeSunrise = resultWeather!["sunriseTime"]!
        let timeSunset = resultWeather!["sunsetTime"]!
        
        //Convert timestamp
        let dateSunrise = NSDate(timeIntervalSince1970: TimeInterval(timeSunrise as! NSNumber))
        let dateSunset = NSDate(timeIntervalSince1970: TimeInterval(timeSunset as! NSNumber))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let sunrise = dateFormatter.string(from: dateSunrise as Date)
        let sunset = dateFormatter.string(from: dateSunset as Date)
        
        let a = Int(round(Double(tempMax as! NSNumber)))
        let b = Int(round(Double(tempMin as! NSNumber)))
        let c = Int(Double(precip as! NSNumber)*100)
        
        //Assign to labels
        LabelDetail.text = resultWeather?["summary"] as? String
        LabelTemperature.text = "\(a)°C / \(b)°C"
        LabelPrecip.text = "Risque de précipitation : \(c) %"
        LabelSun.text = "Lever : \(sunrise) Coucher : \(sunset)"
        
        let urlimage = ViewController.downloadImage(weath: resultWeather!["icon"] as! String)
        WeatherImage.af_setImage(withURL: urlimage)
        
    }
    
    override func viewDidLayoutSubviews() {
        return
    }
    
}
