//
//  ViewController.swift
//  Task6
//
//  Created by sophia on 7/5/19.
//  Copyright © 2019 sophia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var temperatures: [Weather] = []
    var summary = String()
    var temperature = String()
    var icon = String()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatures.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableview.dequeueReusableCell(withIdentifier: "labelCell")

        cell?.textLabel?.text = String(format: "%.2f", temperatures[indexPath.row].temperature)
        cell?.detailTextLabel?.text = temperatures[indexPath.row].icon
        //cell?.textLabel?.backgroundColor=UIColor.gray
        
        
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Weather.forecase(withLocation: "37.8267,-122.4233") { (results:[Weather]) in
             self.temperatures = results
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
        }
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.summary=temperatures[indexPath.row].summary
        self.icon = temperatures[indexPath.row].icon
        self.temperature =  String(format: "%.2f", temperatures[indexPath.row].temperature)
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailWeather=segue.destination as! weatherDetailController
        detailWeather.icon = self.icon
        detailWeather.summary = self.summary
        detailWeather.temperature = self.temperature
    }
  
}

