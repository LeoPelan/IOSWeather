//
//  ViewController.swift
//  beginApp
//
//  Created by leo pelan on 24/10/2016.
//  Copyright © 2016 leo pelan. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

class ViewController: UITableViewController {
    
    var resultWeather : WeatherArray?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Create refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.blue
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refresh(){
        SWRequestmanager.sharedInstance.fetchWeather(onSuccess: {(result) in
            self.resultWeather = result
            self.refreshControl?.endRefreshing()
            self.reload()
        }) {(error) in
            print("Error => \(error)")
        }
    }
    
    func reload() {
        self.tableView.reloadData()
    }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return resultWeather?.count ?? 0
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RootWeatherCell.identifier) as? RootWeatherCell else {
            return UITableViewCell()
            }
            
            guard let objWeather = self.resultWeather?[indexPath.row] ,
            let summary = objWeather["summary"] as? String,
            let time = objWeather["time"] as? Int else {
                return cell
            }
            
            //Set background UIImage
            let tempImageView = UIImageView(image: UIImage(named: "weather.png"))
            tempImageView.frame = self.tableView.frame
            self.tableView.backgroundView = tempImageView;
            
            //Convert Timestamp to correct date format
            let date = NSDate(timeIntervalSince1970: TimeInterval(time))
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "fr_FR")
            formatter.dateFormat = "EEEE dd MMM"
            let finaleDate = formatter.string(from: date as Date)
            
            //Get Icons from downloadImage()
            let urlimage = ViewController.downloadImage(weath: objWeather["icon"] as! String)
            
            //Set labels & Images in cells
            cell.titleLabel.text = "\(finaleDate)"
            cell.detailLabel.text = "\(summary)"
            cell.weatherImage.af_setImage(withURL: urlimage)
            
            return cell

            }
    
   static func downloadImage(weath: String) -> URL {
        
        
        let dictionnaryWeather = ["rain" : "http://openweathermap.org/img/w/10d.png",
                                  "partly-cloudy-day":"http://openweathermap.org/img/w/02d.png",
                                  "partly-cloudy-night":"http://openweathermap.org/img/w/02n.png",
                                  "clear-day":"http://openweathermap.org/img/w/01d.png",
                                  "clear-night":"http://openweathermap.org/img/w/01n.png"]
    
        for (clef, valeur) in dictionnaryWeather{
            if clef == weath{
                return URL(string: valeur)!
            }
            
        }
        return URL(string: "test")!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Create and perform segue to DetailViewController
        let selectedRowWeather = resultWeather?[indexPath.row]
        let destinationVC = DetailViewController()
        destinationVC.resultWeather = selectedRowWeather
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            vc.resultWeather = selectedRowWeather
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
//    @IBAction func userTapped() {
//        self.performSegue(withIdentifier: "SegueDetail", sender: nil)
//    }
}
    

    



