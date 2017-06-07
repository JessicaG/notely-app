import UIKit
import Alamofire

class DataViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLink: UITextView!
    @IBOutlet weak var errorMessageLabel: UILabel!

    lazy var alertController : UserAlertsViewController = UserAlertsViewController()

    var baseNotelyUrl: String = "https:/localhost:3000/api/v1/"
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataLabel!.text = dataObject
    }

    @IBAction func loginButton(_ sender: Any) {
        if emailField.text!.isEmpty {
            errorMessageLabel.text = "Username Empty."
        } else if passwordField.text!.isEmpty {
            errorMessageLabel.text = "Password Empty."
        } else {
            self.loginUser()
            // create a session here
            
        }
    }


    // after successful login, present view controller with phone number field and call api/v1/authenticate/:number
    // after phone number is submitted, present view controller with a field to enter in code api/v1/authenticate/verify
    // after code is entered in, present a screen to add a new note
    // when a user creates a new note, should be saved to local storage

    
    // Login Request
    func loginUser() {
        self.performLogin(email: self.emailField.text!, password: self.passwordField.text!,
                          success: {
                            (response : DataResponse<Any>)
                            in
                            let storyboard = UIStoryboard(name: "twoFactorScreen", bundle: nil)
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
                                    let title = "Invalid Credentials."
                                    let message = "The username and password combination you entered was wrong."
                                    self.alertController.alertUserWithNoAction(alertTitle: title, alertMessage: message, controller: self)
                                default :
                                    break
                                }
                                
                            }
                            
                            
        }
        )
    }

    func performLogin(email : String,
                      password : String,
                      success successProc : ((DataResponse<Any>) -> ())?,
                      failure failureProc : ((DataResponse<Any>) -> ())? ) {

        let urlString = "\(baseNotelyUrl)/login/"
        let headers : [String: String]? = ["Content-Type": "application/json",
                                           "email": email,
                                           "password": password ]

        Alamofire.request(urlString,
                          method: .post,
                          parameters: nil,
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

    // Registration Request
    func newUserRegistration() {
        self.performRegistration(email: self.emailField.text!, password: self.passwordField.text!,
                          success: {
                            (response : DataResponse<Any>)
                            in
                            let storyboard = UIStoryboard(name: "twoFactorScreen", bundle: nil)
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
                                    let title = "Invalid Credentials."
                                    let message = "The username and password combination you entered was wrong."
                                    self.alertController.alertUserWithNoAction(alertTitle: title, alertMessage: message, controller: self)
                                default :
                                    break
                                }
                                
                            }
                            
                            
        }
        )
    }


    func performRegistration(email : String,
                             password : String,
                             success successProc : ((DataResponse<Any>) -> ())?,
                             failure failureProc : ((DataResponse<Any>) -> ())? ) {

        let urlString = "\(baseNotelyUrl)/registration/"
        let headers : [String: String]? = ["Content-Type": "application/json",
                                           "email": email,
                                           "password": password ]

        Alamofire.request(urlString,
                          method: .post,
                          parameters: nil,
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

