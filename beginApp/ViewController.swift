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
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var resultWeather : WeatherArray?
    
    //let weatherDataSource = RootWeatherDataSource()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.blue
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        SWRequestmanager.sharedInstance.fetchWeather(onSuccess: {(result) in
            self.resultWeather = result
            self.reload()
        }) {(error) in
            print("Error => \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
//        self.weatherDataSource.updateWeather { [weak self] _ in
            self.reload()
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
            
            let tempImageView = UIImageView(image: UIImage(named: "weather.jpg"))
            tempImageView.frame = self.tableView.frame
            self.tableView.backgroundView = tempImageView;
            
            let date = NSDate(timeIntervalSince1970: TimeInterval(time))
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "fr_FR")
            formatter.dateFormat = "EEEE dd MMM"
            let finaleDate = formatter.string(from: date as Date)
            
            let urlimage = downloadImage(weath: objWeather["icon"] as! String)
            
            cell.titleLabel.text = "\(finaleDate)"
            cell.detailLabel.text = "\(summary)"
            
            
            
            cell.weatherImage.af_setImage(withURL: urlimage)
            return cell

            }
    
    func downloadImage(weath: String) -> URL {
        
        
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
        print("User selected \(index)")
    }
    
    @IBAction func userTapped() {
        self.performSegue(withIdentifier: "SegueDetail", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SegueDetail"{
//            guard let selectedIndex = self.tableView.indexPathForSelectedRow
//            let WeatherObject = self.weatherDataSource.getWeatherObject(forIndexRow: selectedIndex.row)}else {return}
//            guard let DetailViewController = segue.destination as? DetailViewController
//            segue.destination as? DetailViewController else {return}
//            DetailViewController.weatherObj = weatherObj
//        }
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "SegueDetail"{
//                let selectedIndex = self.tableView.indexPathForSelectedRow
//                let WeatherObject = self.resultWeather?(forIndexRow: selectedIndex?.row)} else {return}
//                guard let DetailViewController = segue.destination as? DetailViewController
//                segue.destination as? DetailViewController else {return}
//                DetailViewController.weatherObj = weatherObj
//            }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        // Create a variable that you want to send
//        
//        let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
//        //let objWeather = self.resultWeather?(forIndexRow:selectedIndex?.row)
//        let newWeatherVar = self.resultWeather
//        // Create a new variable to store the instance of PlayerTableViewController
//        let destinationDVC = segue.destination as? DetailViewController
//        destinationDVC?.weatherObj = newWeatherVar
//    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below
        let selectedRowWeather = resultWeather?[indexPath.row]
        
        // Create an instance of PlayerTableViewController and pass the variable
        let destinationVC = DetailViewController()
        destinationVC.resultWeather = selectedRowWeather
        
        // Let's assume that the segue name is called playerSegue
        // This will perform the segue and pre-load the variable for you to use
        destinationVC.performSegue(withIdentifier: "SegueDetail", sender: self)
    }
}
    

    



