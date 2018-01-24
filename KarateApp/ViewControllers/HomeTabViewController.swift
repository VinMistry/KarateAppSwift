//
//  HomeTabViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nextClassLabel: UILabel!
    
    //MARK: Model Objects
    var dates : GetTheDate = GetTheDate()
    
    //MARK: View Preperation
    
    //Tasks to be completed on the loading of the view
    override func viewDidLoad() {
        super.viewDidLoad()
       setNextClassLabel()
    }
    
    //MARK: Outlet Maniputlation
    private func setNextClassLabel() {
        print(dates.getCurrentDate())
        nextClassLabel.text = dates.nextClassDate()
    }
  
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
