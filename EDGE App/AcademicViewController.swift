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
    var selectedScope = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func filterContentForSearchText(searchText: String) {
        self.filteredAcademic = self.academic.filter({( newApp: Entry ) -> Bool in
            let stringMatch = newApp.label!.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
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

}
