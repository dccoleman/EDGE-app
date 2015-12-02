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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create a new entry object with the given parameters
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveWellnessApp" {
            newEntry = Entry(soc: soc, ac: ac, well: true, app: true, label: (WellnessAppName.text!), url: (WellnessAppUrl.text!), tags: (WellnessAppTags.text!))
            //HERE is where we push to parse
        }
    }
    
}
