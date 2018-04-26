//
//  JapaneseAudioSection.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 25/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import Foundation

struct JapaneseAudioSection {
    //MARK: Variables
    var section : String!
    var expanded : Bool!
    
    //MARK: Initialisers
    
    //Initialises variables
    init(section: String, expanded: Bool ) {
        self.section = section
        self.expanded = expanded
}
}
