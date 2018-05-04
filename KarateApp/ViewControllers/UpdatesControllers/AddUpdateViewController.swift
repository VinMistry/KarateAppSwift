//
//  AddUpdateViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 22/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class AddUpdateViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var mainBodyTextView: UITextView!
    
    var ref = Database.database().reference()
    
    var numberOfPosts : Int! {
        didSet {
            print(numberOfPosts)
        }
    }
    
    var editTitle : String = ""
    
    var editText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //navigationController?.title = "Add New Post"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        titleTextField.text = editTitle
        mainBodyTextView.text = editText
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        numberOfPosts = numberOfPosts+1
        if let title = titleTextField.text,
            let body = mainBodyTextView.text {
            if title.isEmpty || body.isEmpty {
                let alert = UIAlertController(title: "Error: Empty", message: "Title or Main Text is Empty. Please make sure both fields are filled in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                self.ref.child("Posts").child(numberOfPosts.description).updateChildValues([ "title" : title])
                self.ref.child("Posts").child(numberOfPosts.description).updateChildValues([ "text" : body])
                self.ref.child("Posts").child(numberOfPosts.description).updateChildValues([ "dateAndTime" : "\(Date().description)"])
                dismiss(animated: true, completion: nil)
            }
        }
        
        
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
