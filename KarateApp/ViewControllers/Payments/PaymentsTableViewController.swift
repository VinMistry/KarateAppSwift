//
//  PaymentsTableViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 05/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class PaymentsTableViewController: UITableViewController {
    let productsAndPrices = [
        "Single": 500,
        "Monthly":2500,
        ]
    
    let settingsVC = SettingsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return productsAndPrices.count
    }

    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "payments", for: indexPath) as? PaymentsTableViewCell
        else {
                return UITableViewCell()
        }
        // Configure the cell...
        let product = Array(self.productsAndPrices.keys)[(indexPath as NSIndexPath).row]
        let price = self.productsAndPrices[product]!
        cell.mainTextLabel.text = product
        cell.priceLabel.text = "£\(price/100).00"
        cell.accessoryType = .disclosureIndicator
        cell.sizeToFit()
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = Array(self.productsAndPrices.keys)[(indexPath as NSIndexPath).row]
        let price = self.productsAndPrices[product]!
        let checkoutViewController = CheckoutViewController(product: product,
                                                            price: price, settings: self.settingsVC.settings)
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
}
