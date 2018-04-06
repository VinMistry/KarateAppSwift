//
//  ReadUpdateViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 21/03/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class ReadUpdateViewController: UIViewController {
    
    
    @IBOutlet weak var updateTextView: UITextView!
    
    var updateTitle : String = "No Title" {
        didSet {
            print(updateTitle)
            //updateTitleLabel.text = updateTitle
        }
    }
    var updateText : String = "No Text" {
        didSet {
            print(updateText)
            // updateTextView.text = updateText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = updateTitle
         updateTextView.text = updateText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
}
}

