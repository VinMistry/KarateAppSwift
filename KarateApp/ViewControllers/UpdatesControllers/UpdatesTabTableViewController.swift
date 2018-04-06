//
//  UpdatesTabTableViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class UpdatesTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    //Creates a refresh control, which allows data to be refreshed when pulling down on table view
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        let refreshText = NSMutableAttributedString(string: "Fetching New Updates ...")
        let range = refreshText.mutableString.range(of: refreshText.string)
        refreshText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: range)
        refreshControl.attributedTitle = refreshText
        refreshControl.addTarget(self, action: #selector(refreshFire), for: .valueChanged)
        return refreshControl
    }()
    
    var updateTextArray = [String]()
    var updateTitleArray =  [String]()
    var currentUpdateArray = [String]()
    private var model = UpdateModel("","")
    
    private var ref = Database.database().reference()
    private var  databaseHandle : DatabaseHandle?
    
    private func showUpdates() {
       var postTitles = [String]()
       var postText = [String]()
        ref.child("Updates").observeSingleEvent(of: .value) { (newSnap) in
            for child in (newSnap.children){
                let snap = child as? DataSnapshot
                if let actualPost = snap?.value as? String,
                    let titles = snap?.key {
                    var newt = titles.split(separator: ",")
                    print(newt[1])
                    postTitles.append(String(newt[1]))
                    postText.append(actualPost)
                    self.tableView.reloadData()
                    print("Single Event posts: " , actualPost)
                    print("Single Event titles: " , titles)
                }
            }
            self.currentUpdateArray = postText.reversed()
            self.updateTitleArray = postTitles.reversed()
            self.tableView.reloadData()
        }
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = refresher
        showUpdates()
        setUpSearchBar()
        searchBar.showsCancelButton = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func refreshFire()
    {
        model.refreshData()
        updateTextArray =  model.postText.reversed()
        currentUpdateArray = model.postText.reversed()
        updateTitleArray = model.postTitles.reversed()
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        guard !searchText.isEmpty else {
            currentUpdateArray = updateTextArray
            return
        }
        currentUpdateArray = updateTextArray.filter({ update -> Bool in
            return  update.lowercased().contains(searchText.lowercased())
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
        currentUpdateArray = updateTextArray
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
        
        cell.updateTitleLabel.text = updateTitleArray[indexPath.row]
        cell.updateBodyLabel.text = currentUpdateArray[indexPath.row]
        
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
