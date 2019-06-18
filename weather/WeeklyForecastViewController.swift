//
//  WeeklyForecastViewController.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/22/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class WeeklyForecastViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
     var days = 7
    var selected: Bool = false
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            selected = false
            prepareRestart(days: days)
        case 1:
            selected = true
            dataArray = []
            for i in 0..<2{
                dataArray.append(realCity?.days[i])
           }
        default:
            break; 
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var city: String?
    var dataArray: [Day?] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var realCity: City?
    
    var weatherGetter = WeatherGetter()
    override func viewDidAppear(_ animated: Bool) {
        prepareRestart(days: days)
    }
    
    func prepareRestart(days: Int){
        let userDefaults = UserDefaults.standard
        city = userDefaults.string(forKey: "City")
        if let city = city{
            self.weatherGetter.getWeather(city: city, days: days){
                self.realCity = self.weatherGetter.city
                self.dataArray = (self.realCity?.days) ?? []
            }
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "b.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
extension WeeklyForecastViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Day", for: indexPath) as! DayTableViewCell
        let day = dataArray[indexPath.row]!
        cell.temperatre.text = "\(day.day!)°C"
         cell.dateAndDay.text = day.date1
        if (indexPath.row != 0){
          let index = day.date1?.index((day.date1?.startIndex)!, offsetBy: 3)
          cell.dateAndDay.text = day.date1?.substring(to: index!)
        }
        cell.mint.text = "Min \(day.min!)°C"
        cell.maxt.text = "Max \(day.max!)°C"
        cell.mornt.text = "\(day.morn!)°C"
        cell.evet.text = "\(day.eve!)°C"
        cell.nightt.text = "\(day.night!)°C"
        cell.icon.af_setImage(withURL: URL(string:(dataArray[indexPath.row]?.iconLink)! )!)
        return cell
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.4)

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
}

