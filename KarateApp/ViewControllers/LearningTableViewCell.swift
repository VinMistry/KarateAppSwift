//
//  LearningTableViewCell.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 28/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class LearningTableViewCell: UITableViewCell {
    
    @IBOutlet weak var learnCategoryLabel: UILabel!
    
    @IBOutlet weak var learningCategoryImage: UIImageView!
    
    @IBOutlet weak var learningCellView: UIView!
    
    var categoryNames = ["Japanese","Technique"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        learningCellView.clipsToBounds = true
        learningCellView.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
