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
    var updateText: String
    var updateDate: String
    
    init(_ updateTitle: String,_ updateMain: String) {
        self.updateTitle = updateTitle
        self.updateText = updateMain
        self.updateDate = ""
    }
    init() {
        self.updateTitle = ""
        self.updateText = ""
        self.updateDate = ""
    }
    
    init?(_ snapshot: DataSnapshot) {
        
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let updateText = dict["text"] as? String else {return nil}
        guard let updateTitle = dict["title"] as? String else {return nil}
        guard let updateDate = dict["dateAndTime"] as? String else {return nil}
        
        self.updateText = updateText
        self.updateTitle = updateTitle
        self.updateDate = updateDate
    }
}
