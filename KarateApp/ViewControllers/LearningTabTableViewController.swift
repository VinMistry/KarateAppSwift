//
//  LearningTabTableViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class LearningTabTableViewController: UITableViewController {
    
    var japaneseOptions = ["Basics", "Numbers", "Techniques"]
    var techniqueOptions = ["Punches","Kicks","Other"]
    
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "learningCategories", for: indexPath) as! LearningTableViewCell
        
        // Configure the cell...
        let cellClass = LearningTableViewCell()
        let labelText = cellClass.categoryNames[indexPath.section]
        cell.learnCategoryLabel.text = labelText
        
        if indexPath.section == 0 {
            cell.learningCategoryImage.image = #imageLiteral(resourceName: "karateInJapanese")
        }
        else{
            cell.learningCategoryImage.image = #imageLiteral(resourceName: "Jud-gyaku-zuki")
        }
        cell.sizeToFit()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.prepare(for: UIStoryboardSegue.init(identifier: "japaneseOption", source: self, destination: LearnJapaneseTableViewController()), sender: self)
        case 1:
            self.prepare(for: UIStoryboardSegue.init(identifier: "techniqueOption", source: self, destination: LearnTechniqueTableViewController()), sender: self)
        default:
            print("Nothing to do")
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            if let cell = sender as? LearningTableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                if(indexPath.section == 0){
                    if let segueToMVC = segue.destination as? LearnJapaneseTableViewController {
                        segueToMVC.option = 0
                    }
                }
                else {
                    if let segueToMVC = segue.destination as? LearnJapaneseTableViewController {
                        segueToMVC.option = 1
                    }
                }
                
        }
    }
}
