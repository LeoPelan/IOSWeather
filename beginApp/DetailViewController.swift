//
//  DetailViewController.swift
//  beginApp
//
//  Created by Léo Pelan on 26/10/2016.
//  Copyright © 2016 Léo Pelan. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController{
    @IBOutlet var LabelDetail: UILabel!
    
    var weatherObj : WeatherArray?
    var resultWeather : WeatherObject?
    
    static let identifier = "DetailWeatherCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let summary = resultWeather?["summary"] as? String
        
        
        if weatherObj != nil {
            LabelDetail.text = summary
        }
    }
    
    override func viewDidLayoutSubviews() {
        return
    }
    
}
