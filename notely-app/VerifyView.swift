//
//  VerifyView.swift
//  notely-app
//
//  Created by Jessica West on 6/7/17.
//  Copyright © 2017 Jessica West. All rights reserved.
//

import Foundation
import UIKit

class VerifyViewController : UIViewController {

    @IBOutlet weak var verifyNumberField: UITextField!
    @IBOutlet weak var verifyUserButton: UIButton!

    lazy var alertController : UserAlertsViewController = UserAlertsViewController()

    var baseNotelyUrl: String = "https:/localhost:3000/api/v1/"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func verifyUser(_ sender: Any) {
        // verify user action
    }
}

