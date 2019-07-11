////
////  DaysListViewController.swift
////  Wheater
////
////  Created by Bianca on 11/07/19.
////  Copyright © 2019 Bianca. All rights reserved.
////
//
//import UIKit
//
//class DaysListViewController: UITableViewController {
//    let daysList = [ListForecast]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return daysList.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let days = daysList[indexPath.row]
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
//        cell.textLabel?.text = days.main.temp.description
//        
//        return cell
//    }
//    
//    
//}
