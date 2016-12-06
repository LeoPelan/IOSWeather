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
    
    var resultWeather : WeatherObject?
    
    let identifier = "SegueDetail"
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "weather.png")!)
        
        super.viewDidLoad()
        
        LabelDetail.text = resultWeather?["summary"] as? String
        
        let tempMax = resultWeather!["temperatureMax"]!
        let tempMin = resultWeather!["temperatureMin"]!
        let precip = resultWeather!["temperatureMin"]!

        let a = Int(round(Double(tempMax as! NSNumber)))
        let b = Int(round(Double(tempMin as! NSNumber)))
        let c = Int(round(Double(precip as! NSNumber)))
        
        LabelTemperature.text = "\(a)°C / \(b)°C"
        LabelPrecip.text = "Risque de précipitation : \(c) %"
        
        let urlimage = ViewController.downloadImage(weath: resultWeather!["icon"] as! String)
        WeatherImage.af_setImage(withURL: urlimage)
        
  //  TemperatureMin.text = "\(tempMin)"
        
        
//        if weatherObj != nil {
//            LabelDetail.text = summary
//        }
    }
    
    override func viewDidLayoutSubviews() {
        return
    }
    
}
