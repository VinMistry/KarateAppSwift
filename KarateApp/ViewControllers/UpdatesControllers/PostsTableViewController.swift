//
//  PostsTableViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 21/03/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class PostsTableViewController: UITableViewController, UISearchBarDelegate  {
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: Private Variables
    private var currentPostArray = [UpdateModel]()
    private var postCollection = [UpdateModel]()
    private var reversedArr = [UpdateModel]()
    private var ref: DatabaseReference!
    private var post = UpdateModel()
    
    //MARK: Public Variables
    var shouldAddButton : Bool = false
    var isInstructor : Bool = false
    
    //Creates a refresh control, which allows data to be refreshed when pulling down on table view
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        let refreshText = NSMutableAttributedString(string: "Fetching New Updates ...")
        let range = refreshText.mutableString.range(of: refreshText.string)
        refreshText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: range)
        refreshControl.attributedTitle = refreshText
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func addTapped() {
        print("Starting addTapped")
        self.performSegue(withIdentifier: "addPost", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        refreshControl = refresher
        ref = Database.database().reference()
        setPosts()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self ,action: #selector(self.addTapped))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        shouldAddPostButtonAppear()
        }
        
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setPosts() {
        ref.child("Posts").observeSingleEvent(of: .value) { (newSnap) in
            print(newSnap)
            for child in newSnap.children {
                let snap = child as? DataSnapshot
                let updateNumber = Int((snap?.key)!)!
                guard let post = UpdateModel(snap!, updateNumber) else { print("No Snap"); return}
                self.postCollection.append(post)
            }
            for post in self.postCollection.reversed() {
                self.reversedArr.append(post)
            }
            self.currentPostArray = self.reversedArr
            self.tableView.reloadData()
            
        }
    }
    
    private func shouldAddPostButtonAppear() {
        if Auth.auth().currentUser != nil{
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).child("instructor").observeSingleEvent(of: .value) { (newSnap) in
                print(newSnap)
                if let val = newSnap.value as? Bool {
                    print(val)
                    self.isInstructor = val
                    if(self.isInstructor == true) {
                        print(self.isInstructor)
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        self.navigationItem.rightBarButtonItem?.title = "Add Post"
                    }
                }
            }
        }
        else {
            print("No User!")
        }
    }
    
    @objc private func refreshPosts() {
        postCollection.removeAll()
        currentPostArray.removeAll()
        reversedArr.removeAll()
        setPosts()
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
    //MARK: Search Bar Functionailty
    private func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        guard !searchText.isEmpty else {
            currentPostArray = reversedArr
            searchBar.showsCancelButton = false
            tableView.reloadData()
            return
        }
        currentPostArray = reversedArr.filter({ update -> Bool in
            return  update.updateText.lowercased().contains(searchText.lowercased())
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
        currentPostArray = reversedArr
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.endEditing(true)
        self.searchBar.endEditing(true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentPostArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "updates", for: indexPath) as? UpdatesTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell...
        cell.updateTitleLabel.text = currentPostArray[indexPath.row].updateTitle
        cell.updateBodyLabel.text = currentPostArray[indexPath.row].updateText
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showUpdate" {
            print("Starting showUpdate Segue")
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let segueToMVC = (segue.destination.contents as? ReadUpdateViewController) {
                print("Segue titles", reversedArr[indexPath.row].updateTitle)
                print("Segue text", reversedArr[indexPath.row].updateText)
                segueToMVC.updateTitle = reversedArr[indexPath.row].updateTitle
                segueToMVC.updateText = reversedArr[indexPath.row].updateText
                segueToMVC.isInstructor = self.isInstructor
                let postNumber = reversedArr[indexPath.row].updateNumber
                segueToMVC.postNumber = postNumber
            }
        }
        if segue.identifier == "addPost"{
           if let dest = (segue.destination.contents as? AddUpdateViewController) {
                print("ADD POST: " ,reversedArr[0].updateNumber)
                dest.numberOfPosts = reversedArr[0].updateNumber
            }
        }
    }
}
//Allows access to the view controller which is embedded in the navigation controller
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}


