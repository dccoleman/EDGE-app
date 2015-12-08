//
//  WellnessAppDetailsViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/28/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class WellnessAppDetailsViewController: UITableViewController {
    
    var newEntry:Entry?
    var object: PFObject!
    
    @IBOutlet weak var WellnessAppName: UITextField!
    @IBOutlet weak var WellnessAppUrl: UITextField!
    @IBOutlet weak var WellnessAppTags: UITextField!
    @IBOutlet weak var AppName: UITextField!
    @IBOutlet weak var DeveloperName: UITextField!
    
    var soc = false
    var ac = false
    
    @IBAction func SocialUpdated(sender: UISwitch) {
        if soc {
            soc = false
            print("Social Off")
        }
        else {
            soc = true
            print("Social On")
        }
    }
    
    @IBAction func AcademicUpdated(sender: UISwitch) {
        if ac {
            ac = false
            print("Academic Off")
        }
        else {
            ac = true
            print("Academic On")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.object = PFObject(className: "Entry")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction() {
        
        print("Saving")
        print("Saving \n")
        print("Saving \n")
        
        self.object["Social"] = self.soc
        self.object["academic"] = self.ac
        self.object["wellness"] = true
        self.object["app"] = WellnessAppName.text?.isEmpty
        self.object["label"] = WellnessAppName.text
        self.object["url"] = WellnessAppUrl.text
        self.object["tags"] = WellnessAppTags.text
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
    
    //create a new entry object with the given parameters
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveWellnessApp" {
            newEntry = Entry(soc: soc, ac: ac, well: true, app: true, label: (WellnessAppName.text!), url: (WellnessAppUrl.text!), tags: (WellnessAppTags.text!))
            saveAction()
        }
    }
    
}
