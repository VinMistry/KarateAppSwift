//
//  UserModel.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 22/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import Foundation
import Firebase

class UserModel  {
    
    //MARK: Public Variables
    var name : String
    var instructor : Int
    var grade : String
    
    //MARK: Initialisers
    //Parameterised initialiser/constructor
    init(name : String, instructor : Int, grade : String) {
        self.name = name
        self.instructor = instructor
        self.grade = grade
    }
    
    //Basic initialiser/constructor
    init() {
        self.name = "name"
        self.instructor = 0
        self.grade = "grade"
    }
    
    //Takes the data snapshot and extract the values from it for grade, name and if they are an instructor
    init?(_ snapshot : DataSnapshot) {
        //Creates dictionary (key: value) data structure
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        //Uses the key from the database to get the individual values
        guard let name = dict["name"] as? String else {return nil}
        guard let grade = dict["grade"] as? String else {return nil}
        guard let instructor = dict["instructor"] as? Int else {return nil}
        
        //Assigns the values to the models variables
        self.name = name
        self.instructor = instructor
        self.grade = grade
    }
    
    
}
