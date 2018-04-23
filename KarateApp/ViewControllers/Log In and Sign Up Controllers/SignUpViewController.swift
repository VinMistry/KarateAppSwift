//
//  SignUpViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text, let name = nameTextField.text
        {
            //Register user with firebase
            Auth.auth().createUser(withEmail: email, password: pass, completion: { (user,error) in
                //Check user is not nil
                if user != nil {
                    //User is found go to homescreen
                    guard let uid = user?.uid else {
                        return
                    }
                    let usersRef = self.ref.child("users").child(uid)
                    let values = ["name": name]
                    usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if let errorToReport = err {
                            print(errorToReport)
                            return
                        }
                        print("User Successfully Added To DB")
                    })
                    Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                        if user != nil {
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
                    self.performSegue(withIdentifier: "accountDetails", sender: self)
                }
                else {
                    //Error: check error show message
                    print(error ?? "")
                    let alert = UIAlertController(title: "Error: Unable to Register", message:
                        error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss keyboard when view is tapped on
        nameTextField.resignFirstResponder()
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
