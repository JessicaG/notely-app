//
//  SingleNoteViewController.swift
//  notely-app
//
//  Created by Jessica West on 6/8/17.
//  Copyright © 2017 Jessica West. All rights reserved.
//

import UIKit

//the protocol (or delegate) pattern, so we can update the table view's selected item
protocol NoteViewDelegate {
    //the name of the function that will be implemented
    func didUpdateNoteWithTitle(newTitle : String, andBody newBody :
        String)
}

class SingleNoteViewController: UIViewController, UITextViewDelegate {

    //a variable to hold the delegate (so we can update the table view)
    var delegate : NoteViewDelegate?

    //a variable that links to the main body text view
    @IBOutlet weak var textBody : UITextView!
    //a variable to link the Done button
    @IBOutlet weak var btnDoneEditing: UIBarButtonItem!

    var stringBodyText : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textBody.text = self.stringBodyText

        //makes the keyboard appear immediately
        self.textBody.becomeFirstResponder()

        //allows UITextView methods to be called (so we know when they begin editing again)
        self.textBody.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        //tell the main view controller that we're going to update the selected item
        //but only if the delegate is NOT nil
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(
                newTitle: self.navigationItem.title!, andBody: self.textBody.text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        //sets the color of the Done button to the default blue
        //it's not a pre-defined value like clearColor, so we give it the exact RGB values
        self.btnDoneEditing.tintColor = UIColor(red: 0, green:
            122.0/255.0, blue: 1, alpha: 1)
    }

    func textViewDidChange(_ textView: UITextView) {

        //separate the body into multiple sections
        let components = self.textBody.text.components(separatedBy: "\n")

            //reset the title to blank (in case there are no components with valid text)
        self.navigationItem.title = ""

        //loop through each item in the components array (each item is auto-detected as a String)
        for item in components {
            //if the number of letters in the item (AFTER getting rid of extra white space) is greater than 0...
            if item.trimmingCharacters(in: .whitespacesAndNewlines).characters.count > 0 {}
                //then set the title to the item itself, and break out of the for loop
                    self.navigationItem.title = item
                break
        }
    }

    @IBAction func doneEditingBody() {
        //hides the keyboard
        self.textBody.resignFirstResponder()

        //makes the button invisible (still allowed to be pressed, but that's okay for this app)
        self.btnDoneEditing.tintColor = UIColor.clear

        //tell the main view controller that we're going to update the selected item
        //but only if the delegate is NOT nil
        if self.delegate != nil {

            self.delegate!.didUpdateNoteWithTitle( newTitle: self.navigationItem.title!, andBody: self.textBody.text)
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
