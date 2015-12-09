//
//  AcademicAppDetailsViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/28/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class AcademicAppDetailsViewController: UITableViewController {
    
    //booleans that are set depending on the state of the swtiches
    var soc = false
    var well = false
    
    var object: PFObject!
    
    //IBOutlets for all the text fields in the add screen
    @IBOutlet weak var AcademicAppName: UITextField!
    @IBOutlet weak var AcademicAppUrl: UITextField!
    @IBOutlet weak var AcademicAppTags: UITextField!
    @IBOutlet weak var DeveloperName: UITextField!
    @IBOutlet weak var AppName: UITextField!
    
    //A variable to keep the new entry
    var newEntry:Entry?

    //IBActions that are triggered whenever a switch is hit, toggling the booleans
    //these are used to set the field within the entry so it is put in multiple lists if necessary
    @IBAction func SocialUpdated(sender: UISwitch) {
        if soc {
            soc = false
        }
        else {
            soc = true
        }
    }
    @IBAction func WellnessUpdated(sender: UISwitch) {
        if well {
            well = false
        }
        else {
            well = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.object = PFObject(className: "Entry")
    }
    
    @IBAction func saveAction() {
        
        print("Saving")
        print("Saving \n")
        print("Saving \n")
        
        self.object["Social"] = self.soc
        self.object["academic"] = true
        self.object["wellness"] = self.well
        self.object["app"] = AcademicAppName.text?.isEmpty
        self.object["label"] = AcademicAppName.text
        self.object["url"] = AcademicAppUrl.text
        self.object["tags"] = AcademicAppTags.text
        self.object["DeveloperName"] =  DeveloperName.text
        self.object["appName"] = AppName.text
        
        self.object.saveEventually { (success, error) -> Void in
            
            if (error == nil) {
                
                
                
            }else {
                
                print(error)
                
            }
            
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //create a new entry object with the given parameters from the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveAcademicApp" {
            newEntry = Entry(soc: soc, ac: true, well: well, app: true, label: (AcademicAppName.text!), url: (AcademicAppUrl.text!), tags: (AcademicAppTags.text!))
            
            saveAction()
        }
    }
}
