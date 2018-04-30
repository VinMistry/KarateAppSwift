//
//  HomeTabViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class HomeTabViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Outlets
    @IBOutlet weak var nextClassLabel: UILabel!
    
    //MARK: Model Objects
    var dates : GetTheDate = GetTheDate()
    private var currentPostArray = [UpdateModel]()
    private var postCollection = [UpdateModel]()
    private var reversedArr = [UpdateModel]()
    private var ref: DatabaseReference!
    private var post = UpdateModel()
    
    //MARK: View Preperation
    
    //Tasks to be completed on the loading of the view
    override func viewDidLoad() {
        super.viewDidLoad()
        setNextClassLabel()
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        setPosts()
        print(dates.nextClassDate())
        print(dates.daysTillNextClass)
        print(dates.getAFutureDate(addDays: dates.daysTillNextClass))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        reversedArr.removeAll()
        setPosts()
    }
    
    var count = 0
    private func setPosts() {
        count = 0
        ref.child("Posts").observeSingleEvent(of: .value) { (newSnap) in
            print(newSnap)
            for child in newSnap.children {
                let snap = child as? DataSnapshot
                guard let post = UpdateModel(snap!) else { print("No Snap"); return}
                self.postCollection.append(post)
            }
            for post in self.postCollection.reversed() {
                if self.count < 2 {
                    self.reversedArr.append(post)
                    self.count = self.count + 1
                }
                else {
                    self.count = self.count + 1
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: Outlet Maniputlation
    private func setNextClassLabel() {
       // print(dates.getCurrentDate())
        nextClassLabel.text = dates.nextClassDate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reversedArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentUpdate", for: indexPath)
        cell.textLabel?.text = reversedArr[indexPath.row].updateTitle
        cell.detailTextLabel?.text = reversedArr[indexPath.row].updateText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "readUpdate", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "readUpdate" {
            print("Starting readUpdate Segue")
            if let indexPath = tableView.indexPathForSelectedRow,
             let cell = tableView.cellForRow(at: indexPath),
                let segueToMVC = (segue.destination.contents as? ReadUpdateViewController) {
            
                print("Segue titles", cell.textLabel?.text ?? "")
                print("Segue text", cell.detailTextLabel?.text  ?? "")
                segueToMVC.updateTitle = reversedArr[indexPath.row].updateTitle
                segueToMVC.updateText = reversedArr[indexPath.row].updateText
            }
        }
    }
    
}
