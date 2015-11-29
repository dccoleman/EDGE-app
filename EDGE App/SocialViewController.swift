//
//  SocialViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/23/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class SocialViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var social:[Entry] = socialData
    var filteredSocial = [Entry]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.tableView.reloadData()
    }
    
    //This is the search function.
    //Returns true if the current cell fits the criteria.
    //The tag search is held within the entry class but the rest of the search
    //(label, url, etc) is held here
    
    func filterContentForSearchText(searchText: String) {
        self.filteredSocial = self.social.filter({( newApp: Entry ) -> Bool in
            let stringMatch = newApp.label!.lowercaseString.rangeOfString(searchText.lowercaseString)
            let urlMatch = newApp.url!.lowercaseString.rangeOfString(searchText.lowercaseString)
            let tagMatch = newApp.search(searchText)
            return tagMatch || (stringMatch != nil) || (urlMatch != nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let controller = segue.destinationViewController
            let entry: Entry
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                
                if resultSearchController.active {
                    entry = filteredSocial[indexPath.row]
                } else {
                    entry = social[indexPath.row]
                }
                
                controller.title = entry.label
            }
            
            if (self.resultSearchController.active) {
                self.resultSearchController.active = false
            }
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return self.filteredSocial.count
        } else {
            return self.social.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SocialCell", forIndexPath: indexPath)
        
        let entry: Entry
        if (self.resultSearchController.active) {
            entry = self.filteredSocial[indexPath.row]
        } else {
            entry = self.social[indexPath.row]
        }
        
        cell.textLabel!.text = entry.label
        cell.detailTextLabel!.text = entry.url
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredSocial.removeAll(keepCapacity: false)
        filterContentForSearchText(searchController.searchBar.text!)
        
        tableView.reloadData()
    }
    
    @IBAction func cancelToSocialAppViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveSocialApp(segue:UIStoryboardSegue) {
        if let SocialAppDetailsViewController = segue.sourceViewController as? SocialAppDetailsViewController {
            
            //add the new player to the players array
            if let entry = SocialAppDetailsViewController.newEntry {
                social.append(entry)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: social.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
}
