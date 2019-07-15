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
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var iconIMG: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let defaultCityId: Int = 3448439
    private var arrazinho: [ListForecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast(cityID: defaultCityId)
    }
    
    private func getForecast(cityID: Int) {
        ForecastCurrentDay.getWeather(cityID: cityID) { result in
            switch result {
            case .success(let forecast):
                self.updateUI(forecast)
            case .failure(let error):
                self.sendNotificationError(errorType: error.localizedDescription)
            }
        }
        
        ForecastMultiDays.getWeatherDays(cityID: cityID) { result in
            switch result {
            case .success(let forecast):
                self.arrazinho = forecast.list
                self.tableView.reloadData()
            case .failure(let error):
                self.sendNotificationError(errorType: error.localizedDescription)
            }
        }
    }
    
    private func updateUI(_ forecast: Forecast) {
        navigationItem.title = forecast.name
        tempLabel.text = "\(forecast.main.temp.description)°C"
        tempMinLabel.text = "Min: \(forecast.main.tempMin.description)°C"
        tempMaxLabel.text = "Max: \(forecast.main.tempMax.description)°C"
        if let weather = forecast.weather.first{
            descriptionLabel.text = weather.main
        }
        
        iconIMG.image = forecast.iconIMG
        
        setTableView(tableView)
    }
    
    private func setTableView(_ tableView: UITableView){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = false
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let listVC = segue.destination as? ListTableViewController{
            listVC.delegate = self
        }
    }
    
    private func sendNotificationError(errorType: String){
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
        return 53
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrazinho.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let days = self.arrazinho[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! WeatherDaysViewCell
        print(days.data)
        
        cell.tempMinLabel.text = "Max: \(days.main.tempMin.description)°C"
        cell.tempMaxLabel.text = "Max: \(days.main.tempMax.description)°C"
        cell.icon.image = days.iconIMG
        
        return cell
    }
    
}

extension ViewController: ListTableViewControllerDelegate {
    
    func listTableViewControllerFinished(viewControler: ListTableViewController, cityID: Int) {
        getForecast(cityID: cityID)
        activityIndicator.startAnimating()
        navigationController?.popToRootViewController(animated: true)
    }
}

