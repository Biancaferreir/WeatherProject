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
    private var arrazinho: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast(cityID: defaultCityId)
        tableView.dataSource = self
        tableView.delegate = self
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
                self.arrazinho = [forecast]
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
        
        if let iconURL = forecast.imageURL {
            let data = try? Data(contentsOf: iconURL)
            if let imageData = data {
                let icon = UIImage(data: imageData)
                iconIMG.image = icon
            }
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let days = self.arrazinho[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! WeatherDaysViewCell
        
        cell.title?.text = "teste"
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

