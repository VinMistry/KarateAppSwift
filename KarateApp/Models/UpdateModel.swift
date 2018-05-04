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

    //MARK: Public Variables
    var updateTitle: String
    var updateText: String
    var updateDate: String
    var updateNumber : Int
    //MARK: Private Variables
    private var ref = Database.database().reference()
    private var  databaseHandle : DatabaseHandle?
    
    //MARK: Initialisers
    
    //Basic parameterised initaliser/constructor for creating an example object
    init(_ updateTitle: String,_ updateMain: String,_ updateDate: String, _ updateNumber : Int) {
        self.updateTitle = updateTitle
        self.updateText = updateMain
        self.updateDate = updateDate
        self.updateNumber = updateNumber
    }
    
    //Basic initaliser/constructor for creating an example object
    init() {
        self.updateTitle = "Title"
        self.updateText = "Text"
        self.updateDate = "Date"
        self.updateNumber = 0
    }
    
    //Initialiser takes the data snapshot and gets text, title and date from it
    init?(_ snapshot: DataSnapshot,_ number: Int) {
        
        //Creates dictionary (key: value) data structure
        guard let dict = snapshot.value as? [String:Any] else { return nil }
       
        //Uses the key from the database to get the individual values
        guard let updateText = dict["text"] as? String else {return nil}
        guard let updateTitle = dict["title"] as? String else {return nil}
        guard let updateDate = dict["dateAndTime"] as? String else {return nil}
        
        //Assigns the values to the models variables
        self.updateText = updateText
        self.updateTitle = updateTitle
        self.updateDate = updateDate
        self.updateNumber = number
    }
}
