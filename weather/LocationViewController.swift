//
//  ViewController.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/20/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UISearchResultsUpdating , UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    
    var weatherGetter = WeatherGetter()
    override func viewWillAppear(_ animated: Bool) {
        let backgroundImage = UIImage(named: "b.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        loadListOfCountries()
        tableView.delegate = self
        tableView.dataSource = self
    }
 
    func loadListOfCountries() {
        weatherGetter.readTxt()
        self.dataArray = weatherGetter.cities
        self.tableView.reloadData()
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
             self.searchController?.isActive = true
        self.searchController!.searchBar.becomeFirstResponder()
             searchController.searchBar.window?.makeKeyAndVisible()
    }
    
  
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the name of the city or region"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = true
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    
    //MARK:- search update delegate
    //MARK:-

    func didPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    public func updateSearchResults(for searchController: UISearchController){
        let searchString = searchController.searchBar.text
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country as NSString
            return (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
        })
        self.tableView.reloadData()
    }
    
    //MARK:- search bar delegate
    //MARK:-
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.tableView.reloadData()
    }

    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = filteredArray[indexPath.row]
      
        if let presenter = presentingViewController as? WeeklyForecastViewController {
            presenter.city = selected
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set( selected, forKey: "City")
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredArray[indexPath.row]
        return cell
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
}


