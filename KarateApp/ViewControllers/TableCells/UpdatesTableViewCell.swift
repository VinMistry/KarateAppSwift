//
//  UpdatesTableViewCell.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 15/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {

    @IBOutlet weak var updateTitleLabel: UILabel!
    
    @IBOutlet weak var updateBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
