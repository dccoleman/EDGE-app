//
//  SocialAppDetailsViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/28/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class SocialAppDetailsViewController: UITableViewController {
    var well = false
    var ac = false
    
    var newEntry:Entry?

    @IBAction func WellnessUpdated(sender: UISwitch) {
        if well {
            well = false
            print("Wellness Off")
        }
        else {
            well = true
            print("Wellness On")
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
    
    
    @IBOutlet weak var SocialAppName: UITextField!
    @IBOutlet weak var SocialAppUrlField: UITextField!
    @IBOutlet weak var SocialAppTags: UITextField!
    @IBOutlet weak var WellnessButton: UIView!
    @IBOutlet weak var AcademicButton: UIView!
    @IBOutlet weak var AppName: UITextField!
    @IBOutlet weak var DeveloperName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create a new entry object with the given parameters
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSocialApp" {
            newEntry = Entry(soc: true, ac: ac, well: well, app: true, label: (SocialAppName.text!), url: (SocialAppUrlField.text!), tags: (SocialAppTags.text!))
            //HERE is where we push to parse
        }
    }

}
