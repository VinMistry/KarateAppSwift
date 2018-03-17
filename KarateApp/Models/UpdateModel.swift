//
//  UpdateModel.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 15/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import Foundation
import Firebase
class UpdateModel {

    var updateTitle: String
    private var ref = Database.database().reference()
    private var  databaseHandle : DatabaseHandle?
    var postText = [String]()
    var postTitles = [String]()
    private var postDictionary =  [String : String]()
    var updateMain: String
    
    init(_ updateTitle: String,_ updateMain: String) {
        self.updateTitle = updateTitle
        self.updateMain = updateMain
    }

    @objc func refreshData() {
        ref.child("Updates").observeSingleEvent(of: .value) { (newSnap) in
            self.postTitles.removeAll()
            self.postText.removeAll()
            for child in (newSnap.children){
                let snap = child as? DataSnapshot
                if let actualPost = snap?.value as? String,
                    let titles = snap?.key {
                    var newt = titles.split(separator: ",")
                    print(newt[1])
                    self.postTitles.append(String(newt[1]))
                    self.postText.append(actualPost)
                   // self.tableView.reloadData()
                    print("Single Event posts: " , actualPost)
                    print("Single Event titles: " , titles)
                   // self.refreshControl?.endRefreshing()
                }
            }
        }
    }

}
