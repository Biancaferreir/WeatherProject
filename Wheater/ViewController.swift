//
//  ViewController.swift
//  Wheater
//
//  Created by Bianca on 26/06/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maximusTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    private let defaultCityId: Int = 3448439
    private var fiveDaysWeatherArray: [ForecastListOfDays] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast(cityID: defaultCityId)
    }
    
    private func getForecast(cityID: Int) {
        NetworkHandler.forecastForOneDay(cityID: cityID) { result in
            switch result {
            case .success(let forecast):
                self.updateUI(forecast)
            case .failure(let error):
                self.sendErrorNotification(error.localizedDescription)
            }
        }
        
        NetworkHandler.forecastForFiveDays(cityID: cityID) { result in
            switch result {
            case .success(let forecast):
                self.fiveDaysWeatherArray = forecast.list          
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.sendErrorNotification(error.localizedDescription)
            }
        }
    }
    
    private func updateUI(_ forecast: ForecastOneDay) {
        navigationItem.title = forecast.name
        currentTemperatureLabel.text = "\(forecast.main.temp.description)°C"
        minimumTemperatureLabel.text = "Min: \(forecast.main.tempMin.description)°C"
        maximusTemperatureLabel.text = "Max: \(forecast.main.tempMax.description)°C"
        if let weather = forecast.weather.first{
            weatherDescriptionLabel.text = weather.main
        }
        
        weatherIconImageView.image = forecast.icon
        
        setTableView(tableView)
    }
    
    private func setTableView(_ tableView: UITableView){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = false
        tableView.reloadData()
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let citiesListVC = segue.destination as? CitiesListTableViewController{
            citiesListVC.delegate = self
        }
    }
    
    private func sendErrorNotification(_ errorType: String){
        let errorNotification = UIAlertController(
            title: "Something Went Wrong",
            message: "Error: \(errorType) try again!",
            preferredStyle: .alert
        )
        errorNotification.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(errorNotification, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDaysWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listOfDays = self.fiveDaysWeatherArray[indexPath.row]
        
        let weekDaysNames = Days.getDaysName(listOfDays.date)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! WeatherDaysViewCell
        
        cell.weekDaysNames.text = weekDaysNames
        cell.tempMinLabel.text = "\(listOfDays.main.tempMin.description)°C"
        cell.tempMaxLabel.text = "\(listOfDays.main.tempMax.description)°C"
        cell.icon.image = listOfDays.icon
        
        return cell
    }
}

extension ViewController: CitiesListTableViewControllerDelegate {
    func isCitiesListFinished(viewControler: CitiesListTableViewController, cityID: Int) {
        getForecast(cityID: cityID)
        activityIndicator.startAnimating()
        navigationController?.popToRootViewController(animated: true)
    }
}

