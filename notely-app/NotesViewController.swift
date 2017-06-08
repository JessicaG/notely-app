//
//  NotesViewController.swift
//  notely-app
//
//  Created by Jessica West on 6/8/17.
//  Copyright © 2017 Jessica West. All rights reserved.
//

import Foundation
import UIKit

class NotesViewController : UITableViewController, NoteViewDelegate {

    //an array of dictionaries
    // keys = "title", "body"
    var arrNotes = [[String:String]]()

    //selected index when transitioning (-1 as sentinel value)
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        //read in the saved value. use "as?" to convert "AnyObject" (the type returned by NSUserDefaults) to the array of dictionaries
        //this is in an if-block so no "nil found" errors crash the app
        //this is known as downcasting
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String:String]] {
            //set the instance variable to the newNotes variable
            arrNotes = newNotes
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {

        //we want "the number of elements in the array" to be the number of rows
        return arrNotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")!

        //set the text to the "title" value of the same index of the array
        cell.textLabel!.text = arrNotes[indexPath.row]["title"]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set the selected index before segue
        self.selectedIndex = indexPath.row

        //push the editor view using the predefined segue
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //grab the view controller we're gong to transition to
        let notesEditorVC = segue.destination as!
        SingleNoteViewController
        
        //set the body of the view controller to the selectedIndex's body
        notesEditorVC.stringBodyText =
            arrNotes[self.selectedIndex]["body"]

        //set the title of the navigation bar to the selectedIndex's title
        notesEditorVC.navigationItem.title =
            arrNotes[self.selectedIndex]["title"]

        //set the delegate to "self", so the method gets called here
        notesEditorVC.delegate = self
    }

    func didUpdateNoteWithTitle(newTitle: String, andBody newBody:
        String) {

        //update the respective values
        self.arrNotes[self.selectedIndex]["title"] = newTitle
        self.arrNotes[self.selectedIndex]["body"] = newBody

        //save the notes to the phone
        saveNotesArray()

        //refresh the view
        self.tableView.reloadData()
    }

    func saveNotesArray() {
        //save the newly updated array
        UserDefaults.standard.set(arrNotes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }

    @IBAction func newNote() {

        //new dictionary with 2 keys and test values for both
        let newDict = ["title" : "",
                       "body" : ""]

        //add the dictionary to the front (or top) of the array
        arrNotes.insert(newDict, at: 0)

        //set the selected index to the most recently added item
        self.selectedIndex = 0

        //reload the table ( refresh the view)
        self.tableView.reloadData()

        //save the notes to the phone
        saveNotesArray()

        //push the editor view using the predefined segue
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }


}
