//
//  JapaneseTextSection.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 23/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import Foundation

struct JapaneseTextSection {

    //MARK: Variables
    var section : String!
    var textToAdd : [String]!
    var expanded : Bool!
    
    //MARK: Initialisers
    
    init(section: String, textToAdd: [String], expanded: Bool ) {
        self.section = section
        self.textToAdd = textToAdd
        self.expanded = expanded
    }
}
