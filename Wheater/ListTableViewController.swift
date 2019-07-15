//
//  ListTableViewController.swift
//  Wheater
//
//  Created by Bianca on 01/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import UIKit

protocol ListTableViewControllerDelegate: class {
    func listTableViewControllerFinished(viewControler: ListTableViewController, cityID: Int)
}

class ListTableViewController: UITableViewController {
    
    let cities = City.defaultCities()
    weak var delegate: ListTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Display Cities"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = city.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        delegate?.listTableViewControllerFinished(viewControler: self, cityID: city.id)
    }

}

