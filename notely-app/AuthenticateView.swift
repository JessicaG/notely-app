//
//  AuthenticateView.swift
//  notely-app
//
//  Created by Jessica West on 6/7/17.
//  Copyright © 2017 Jessica West. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AuthenticateViewController : UIViewController {

    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var sendTextButton: UIButton!

    lazy var alertController : UserAlertsViewController = UserAlertsViewController()

    var baseNotelyUrl: String = "https:/localhost:3000/api/v1/"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func sendUserText(_ sender: Any) {
        self.getRequestToken()
    }

    // Verify Request
    func getRequestToken() {
        self.performVerifyRequest(self.phoneNumberField.text!,
                                  success: {
                                    (response : DataResponse<Any>)
                                    in
                                    let storyboard = UIStoryboard(name: "notesHome", bundle: nil)
                                    let theViewController = storyboard.instantiateInitialViewController() as? UITabBarController
                                    let window = UIApplication.shared.delegate?.window
                                    window??.rootViewController = theViewController
                                    self.present(theViewController!, animated: true, completion: nil)
        },
                                  failure: {
                                    (response : DataResponse<Any>)
                                    in
                                    if let statusCode = response.response?.statusCode {
                                        switch(statusCode) {
                                        case 500 :
                                            let title = "Invalid Code"
                                            let message = "The code you provided was invalid, please try again."
                                            self.alertController.alertUserWithNoAction(alertTitle: title, alertMessage: message, controller: self)
                                        default :
                                            break
                                        }
                                        
                                    }
                                    
                                    
        }
        )
    }

    func performVerifyRequest(_ phone_number : String,
                              success successProc : ((DataResponse<Any>) -> ())?,
                              failure failureProc : ((DataResponse<Any>) -> ())? ) {

        let theToken : String = ""
        let urlString = "\(baseNotelyUrl)/authentication/verifyRequest"
        let headers : [String: String]? = ["Content-Type": "application/json",
                                           "X-Auth-Parker-Token": theToken]
        let parameters : [String : Any] = [ "phone_number" : phone_number.trimmingCharacters(in: .whitespaces)]

        Alamofire.request(urlString,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).validate().responseJSON {
                            response in
                            print(response.request)  // original URL request
                            print(response.response) // HTTP URL response
                            print(response.data)     // server data
                            print(response.result)   // result of response serialization

                            if let JSON = response.result.value {
                                print("JSON: \(JSON)")
                            }
        }
    }

}
