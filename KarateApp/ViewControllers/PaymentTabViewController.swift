//
//  PaymentTabViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class PaymentTabViewController: UIViewController, STPPaymentCardTextFieldDelegate {

    @IBOutlet weak var payForNextLessonButton: UIButton!
    
    let paymentTextField = STPPaymentCardTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width, height: 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        payForNextLessonButton.isHidden = true;
        // Do any additional setup after loading the view.
    }

    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        if textField.isValid {
            self.payForNextLessonButton.isHidden = false
        }
    }
    

    
    @IBAction func payForNextLessonButtonPressed(_ sender: UIButton) {
        let card = paymentTextField.cardParams
        
        STPAPIClient.shared().createToken(withCard: card, completion: { (token,error ) in
            if let error = error {
                print(error)
            }
            else if let token = token {
                print(token)
                self.chargeUsingToken(token: token)
            }
        })
    }
    
    func chargeUsingToken(token:STPToken) {
        let requestString = "https://stripe-vm2amt.herokuapp.com"
        let params = ["stripeToken": token.tokenId, "amount": "4", "currency": "gbp", "description": "testRun"]
        //This line of code will suffice, but we want a response
        Alamofire.request(requestString,method: .post, parameters: params, encoding: JSONEncoding.default)
        //with response handler:
        Alamofire.request(requestString).response { response in
            print(response.request!) // original URL request
            print(response.response!) // URL response
            print(response.data!) // server data
            print(response.metrics!) // result of response serialization
        }
    }
    
    
    //MARK: New Stuff
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
