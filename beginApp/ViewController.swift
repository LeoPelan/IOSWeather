//
//  ViewController.swift
//  beginApp
//
//  Created by leo pelan on 24/10/2016.
//  Copyright © 2016 leo pelan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var resultWeather : WeatherArray?
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
            let date = NSDate(timeIntervalSince1970: TimeInterval(time))
            
  
            
            cell.titleLabel.text = "\(date)"
            cell.detailLabel.text = "\(summary)"
            return cell
    }
    
    
    @IBAction func userTouchedBtn(){
        
        func showAlert(){
            let alert = UIAlertController(title:"Test alert", message: "Enter correct username", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        if let username = username.text, let password = password.text , username.characters.count > 5, password == "toto42"{
        performSegue(withIdentifier: "ShowDetail", sender: nil)
        }
        
    }


}

