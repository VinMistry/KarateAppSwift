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
    
    var isInstructor : Bool = false
    var postNumber : Int = 0 {
        didSet {
            print(postNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = updateTitle
        updateTextView.accessibilityIdentifier = "UpdateTextBody"
        updateTextView.text = updateText
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self ,action: #selector(self.editTapped))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        shouldEditPostButtonAppear()
    }
    
    @objc private func editTapped() {
        print("Starting editTapped")
        performSegue(withIdentifier: "editPost", sender: self)
    }
    
    private func shouldEditPostButtonAppear() {
        if(isInstructor == true) {
            print(isInstructor)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.title = "Edit Post"
        }
        else {
            print("No User!")
        }
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
        if(segue.identifier == "editPost"){
            if let dest = (segue.destination.contents as? AddUpdateViewController) {
                postNumber = postNumber-1
                dest.numberOfPosts = postNumber
                dest.editTitle = updateTitle
                dest.editText = updateText
            }
        }
    }
}

