//
//  AcademicViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/23/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class AcademicViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var academic:[Entry] = academicData
    var filteredAcademic = [Entry]()
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
        self.filteredAcademic = self.academic.filter({( newApp: Entry ) -> Bool in
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
                    entry = filteredAcademic[indexPath.row]
                } else {
                    entry = academic[indexPath.row]
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
            return self.filteredAcademic.count
        } else {
            return self.academic.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AcademicCell", forIndexPath: indexPath)
        
        let entry: Entry
        if (self.resultSearchController.active) {
            entry = self.filteredAcademic[indexPath.row]
        } else {
            entry = self.academic[indexPath.row]
        }
        
        cell.textLabel!.text = entry.label
        cell.detailTextLabel!.text = entry.url
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredAcademic.removeAll(keepCapacity: false)
        filterContentForSearchText(searchController.searchBar.text!)
        
        tableView.reloadData()
    }
    
    @IBAction func cancelToAcademicAppViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveAcademicApp(segue:UIStoryboardSegue) {
        if let AcademicAppDetailsViewController = segue.sourceViewController as? AcademicAppDetailsViewController {
            
            //add the new player to the players array
            if let entry = AcademicAppDetailsViewController.newEntry {
                academic.append(entry)
                print(entry.label!)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: academic.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }

}
