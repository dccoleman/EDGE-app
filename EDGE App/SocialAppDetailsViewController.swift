//
//  SocialAppDetailsViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/28/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class SocialAppDetailsViewController: UITableViewController {
    
    var newEntry:Entry?

    @IBOutlet weak var SocialAppName: UITextField!
    @IBOutlet weak var SocialAppUrlField: UITextField!
    @IBOutlet weak var SocialAppTags: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create a new entry object with the given parameters
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSocialApp" {
            print(SocialAppTags.text!)
            newEntry = Entry(soc: true, ac: false, well: false, app: true, label: (SocialAppName.text!), url: (SocialAppUrlField.text!), tags: (SocialAppTags.text!))
            //HERE is where we push to parse
        }
    }

}
