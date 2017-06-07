//
//  UserAlertsViewController.swift
//  notely-app
//
//  Created by Jessica West on 6/7/17.
//  Copyright © 2017 Jessica West. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class UserAlertsViewController: UIViewController {

    let locationManager : CLLocationManager = CLLocationManager()

    //------------------------
    func alertUserWithNoAction(alertTitle: String, alertMessage: String, controller: UIViewController) {
        let actionSheet =  UIAlertController(title: alertTitle,
                                             message: alertMessage,
                                             preferredStyle: .alert)

        actionSheet.addAction(UIAlertAction(title: "Okay",
                                            style: UIAlertActionStyle.default,
                                            handler: {
                                                (action: UIAlertAction) -> Void in

        }))

        controller.present(actionSheet, animated: false, completion: nil)
    }

    //------------------------
    func alertUserWithDismissAction(alertTitle: String, alertMessage: String, controller: UIViewController) {
        let actionSheet =  UIAlertController(title: alertTitle,
                                             message: alertMessage,
                                             preferredStyle: .alert)

        actionSheet.addAction(UIAlertAction(title: "Okay",
                                            style: UIAlertActionStyle.default,
                                            handler: {
                                                action in
                                                controller.dismiss(animated: true, completion: nil)
        }))

        controller.present(actionSheet, animated: false, completion: nil)
    }

    //------------------------
    func alertUserWithPresentationAction(alertTitle: String, alertMessage: String, controller: UIViewController, storyboard: String, destination: String) {
        let actionSheet =  UIAlertController(title: alertTitle,
                                             message: alertMessage,
                                             preferredStyle: .alert)

        actionSheet.addAction(UIAlertAction(title: "Okay",
                                            style: UIAlertActionStyle.default,
                                            handler: {
                                                action in
                                                let theStoryboard = UIStoryboard(name: storyboard, bundle: nil)
                                                let theViewController = theStoryboard.instantiateViewController(withIdentifier: destination)
                                                controller.present(theViewController, animated: false, completion: nil)
        }))

        controller.present(actionSheet, animated: false, completion: nil)
    }


    //------------------------
    func alertLocationError(alertTitle: String, alertMessage: String, controller: UIViewController) {
        let actionSheet =  UIAlertController(title: alertTitle,
                                             message: alertMessage,
                                             preferredStyle: .alert)

        actionSheet.addAction(UIAlertAction(title: "Okay",
                                            style: UIAlertActionStyle.default,
                                            handler: {
                                                action in
                                                self.locationManager.requestAlwaysAuthorization()

        }))
        
        controller.present(actionSheet, animated: false, completion: nil)
    }
    
}
