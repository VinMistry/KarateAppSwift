//
//  LogInViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            //Sign in user with firebase
            Auth.auth().signIn(withEmail: email, password: pass, completion: { (user,error) in
                if user != nil {
                    //User is found send to homescreen
                    self.performSegue(withIdentifier: "toHome", sender: self)
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                }
                else{
                    //Error: check message show message
                    print(error ?? "")
                    let alert = UIAlertController(title: "Error: Unable to Sign In", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    //Colapses keyboard to allow user to continue navigating etc 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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
