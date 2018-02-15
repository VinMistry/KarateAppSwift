//
//  UpdatesTabTableViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class UpdatesTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var updateArray = [UpdateModel]()
    var currentUpdateArray = [UpdateModel]()
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    private func setUpUpdates() {
        updateArray.append(UpdateModel("hello","my name is blah"))
        updateArray.append(UpdateModel("hjijj","Pink is a colour"))
        updateArray.append(UpdateModel("pants","pants are grey"))
        updateArray.append(UpdateModel("wait","what time is it?"))
        currentUpdateArray = updateArray
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUpdates()
        setUpSearchBar()
        searchBar.showsCancelButton = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        guard !searchText.isEmpty else {
            currentUpdateArray = updateArray
            return
        }
        currentUpdateArray = updateArray.filter({ update -> Bool in
            return  update.updateMain.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        currentUpdateArray = updateArray
        tableView.reloadData()
        
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
        return currentUpdateArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "updates", for: indexPath) as? UpdatesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.updateTitleLabel.text = currentUpdateArray[indexPath.row].updateTitle
        cell.updateBodyLabel.text = currentUpdateArray[indexPath.row].updateMain
        
        return cell
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
