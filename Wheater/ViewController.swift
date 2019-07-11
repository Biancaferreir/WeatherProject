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
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var iconIMG: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let defaultCityId: Int = 3448439
    
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
        
        //teste para ver se tem resultados dos multiplos dias
        ForecastMultiDays.getWeatherDays(cityID: cityID) { result in
            switch result {
            case .success(let forecast):
                print("success")
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
                self.iconIMG.image = icon
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
    
    func sendNotificationError(errorType: String){
        let errorNotification = UIAlertController(title: "Something Went Wrong", message: "Error: \(errorType) try again!", preferredStyle: .alert)
        errorNotification.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(errorNotification, animated: true)
    }
}

extension ViewController: ListTableViewControllerDelegate {
    func listTableViewControllerFinished(viewControler: ListTableViewController, cityID: Int) {
        getForecast(cityID: cityID)
        activityIndicator.startAnimating()
        navigationController?.popToRootViewController(animated: true)
    }
}


