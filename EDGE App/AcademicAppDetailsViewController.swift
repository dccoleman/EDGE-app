//
//  AcademicAppDetailsViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/28/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class AcademicAppDetailsViewController: UITableViewController {
    
    var soc = false
    var well = false
    
    var object: PFObject!
    
    //IBOutlets for all the text fields in the add screen
    @IBOutlet weak var AcademicAppName: UITextField!
    @IBOutlet weak var AcademicAppUrl: UITextField!
    @IBOutlet weak var AcademicAppTags: UITextField!
    
    //A variable to keep the new entry
    var newEntry:Entry?

    @IBOutlet weak var DeveloperName: UITextField!
    @IBOutlet weak var AppName: UITextField!
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON when the cell is clicked
        
        // get correct URL from the selected table cell !!!
        // just go to google for now
        let url  = NSURL(string: "http://www.google.com"); // Change the URL with your URL Scheme
        if UIApplication.sharedApplication().canOpenURL(url!) == true
        {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
}
