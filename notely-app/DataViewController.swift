import UIKit
import Alamofire

class DataViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLink: UITextView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
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
        self.dataLabel!.text = dataObject
    }

    @IBAction func loginButton(_ sender: Any) {
        if emailField.text!.isEmpty {
            errorMessageLabel.text = "Username Empty."
        } else if passwordField.text!.isEmpty {
            errorMessageLabel.text = "Password Empty."
        } else {
            // create a session here
            
        }
    }
    
    func getRequestToken() {
        
    
    }
    
    func performLogin(_email : String,
                      password : String,
                      success successProc : ((DataResponse<Any>) -> ())?,
                      failure failureProc : ((DataResponse<Any>) -> ())? ) {
        
        let urlString = ""
        let headers : [String: String]? = ["Content-Type": "application/json",
                                           "email": email,
                                           "password": password ]
        
    
    }

}

