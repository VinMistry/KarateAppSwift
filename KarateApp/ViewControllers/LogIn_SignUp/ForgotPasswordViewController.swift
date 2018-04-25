//
//  ForgotPasswordViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 19/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class ForgotPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendResetEmailButton(_ sender: Any) {
        print(emailTextField.text!)
        if let emailAdd = emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: emailAdd) { (error) in
                let alert = UIAlertController(title: "Password Reset", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
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
