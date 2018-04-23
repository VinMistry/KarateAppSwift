//
//  PaymentsTableViewCell.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 21/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class PaymentsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        // Initialization code
    }
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var mainTextLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
