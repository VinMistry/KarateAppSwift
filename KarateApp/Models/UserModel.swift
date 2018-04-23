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
    
    var name : String
    var instructor : Int
    var grade : String
    
    init(name : String, instructor : Int, grade : String) {
        self.name = name
        self.instructor = instructor
        self.grade = grade
    }
    
    init() {
        self.name = "name"
        self.instructor = 0
        self.grade = "grade"
    }
    
    init?(_ snapshot : DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let name = dict["name"] as? String else {return nil}
        guard let grade = dict["grade"] as? String else {return nil}
        guard let instructor = dict["instructor"] as? Int else {return nil}
        
        self.name = name
        self.instructor = instructor
        self.grade = grade
    }
    
    
}
