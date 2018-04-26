//
//  ExpandableHeaderView.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 23/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    //MARK: Variables
    var delegate : ExpandableHeaderViewDelegate?
    var section : Int!
    
    //MARK: Initialisers
    //Initialiser adds tap recogniser
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    //Init required by Swift
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Method for expanding header section in table view
    @objc func selectHeaderAction(gestureRecogniser : UITapGestureRecognizer){
        let cell = gestureRecogniser.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    //Initialises attributes
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    //Sets view colours etc.
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.darkGray
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
