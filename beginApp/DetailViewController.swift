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
    
    var weatherObj : WeatherObject!
    
    static let identifier = "DetailWeatherCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if weatherObj != nil {
//            label.text = "\(weatherObj["summary"])"
//        }
    }
    
    override func viewDidLayoutSubviews() {
        return
    }
    
}
