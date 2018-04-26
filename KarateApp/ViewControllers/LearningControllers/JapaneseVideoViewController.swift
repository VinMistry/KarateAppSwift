//
//  JapaneseVideoViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 28/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import WebKit
class JapaneseVideoViewController: UIViewController {

    @IBOutlet weak var videoWebView: WKWebView!
    
    @IBOutlet weak var optionSelectedLabel: UILabel!
    
    var videoCode : String = "uU5lkWqcdm0"
    var optionSelected : String = "None" {
            didSet {
                if(optionSelected == "Greetings"){
                    videoCode = "uU5lkWqcdm0"
                }
                else if(optionSelected == "Numbers"){
                    videoCode = "bOUqVC4XkOY"
                }
                else{
                   videoCode = "2WEfJ2zBFqs"
                }
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode: videoCode)
        // Do any additional setup after loading the view.
        optionSelectedLabel.text = "Watch \(optionSelected)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getVideo(videoCode : String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        videoWebView.load(URLRequest(url: url!))
    }

}
