//
//  AcademicViewController.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/23/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class AcademicViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    //The list of entries. Sourced from parse
    var academic:[Entry] = academicData
    
    //Parse object list of entries
    var entryObjects: NSMutableArray! = NSMutableArray()
    
    //The filtered (searched) list
    var filteredAcademic = [Entry]()
    
    //Controller that manages all the searching
    var resultSearchController = UISearchController()
    
    
    //If the view loads, this is called
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //causes the search results to override whenever the view
        //comes into focus. Fixes black screens when tabbing back
        //to a previous search
        self.definesPresentationContext = true
        
        //sets up the results search controller. This is how we search
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        //reload the table data just to ensure
        //it's saved
        self.tableView.reloadData()
    }
    
    //calls when the view appears
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        fetchAllObjectsFromLocalDatastore()
        print("Fetching Objects")
        fetchAllObjects()
    }
    
    ///updats the Entrty data to sycn it witht ther data being held in the local Database
    func updateData()
    {
        var first: Bool = true;
        for var index = 0; index < entryObjects.count; ++index
        {
            
            let object: PFObject = self.entryObjects.objectAtIndex(index) as! PFObject
            
            let newEntry : Entry = Entry(soc: (object["Social"] as? Bool)!, ac: (object["academic"] as? Bool)!, well: (object["wellness"] as? Bool)!, app: (object["app"] as? Bool)!, label: object["label"] as? String,  url: object["url"] as? String, tags: object["tags"] as? String, devName: object["DeveloperName"] as? String, appName: object["appName"] as? String)
            
            if(first)
            {
                self.academic = [newEntry]
                first = false;
            }
            else
            {
               self.academic.append(newEntry)
            }
            
            
            print("updating Data" + newEntry.label!)
            
            
            
        }
        
    }
    
    /// Fetch all objects from the Local Database
    func fetchAllObjectsFromLocalDatastore() {
        
        let query: PFQuery = PFQuery(className: "Entry")
        
        query.fromLocalDatastore()
        
        query.whereKey("academic", equalTo: true)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if (error == nil) {
                
                let temp: NSArray = objects! as NSArray
                
                self.entryObjects = temp.mutableCopy() as! NSMutableArray
                
                self.updateData()
                
                self.tableView.reloadData()
                
                
                
            }
            else
            {
                print(error)
            }
        }
        
    }
    
    ///fetchs all objects from the severs datbase
    func fetchAllObjects() {
        
        PFObject.unpinAllObjectsInBackgroundWithBlock(nil)
        
        let query: PFQuery = PFQuery(className: "Entry")
        
        //query.whereKey("academic", equalTo: true)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if (error == nil) {
                
                PFObject.pinAllInBackground(objects, block: nil)
                
                self.fetchAllObjectsFromLocalDatastore()
                
            }else {
                
                print(error)
                
            }
            
        }
        
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
            //if any of them are true
            return tagMatch || (stringMatch != nil) || (urlMatch != nil) || searchText.isEmpty
        })
    }
    
    //If we run out of memory. All components of the app are critical
    //so we can't release anything
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //return the number of sections one row will take up
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //set the count correctly depending on which list is active (search or regular)
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return self.filteredAcademic.count
        } else {
            return self.academic.count
        }
    }
    
    //Sets up the table view by creating each cell as necessary
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //dequeue a cell to give it new properties
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AcademicCell", forIndexPath: indexPath)
        
        //grab the entry corresponding to the current row
        let entry: Entry
        if (self.resultSearchController.active) {
            entry = self.filteredAcademic[indexPath.row]
        } else {
            entry = self.academic[indexPath.row]
        }
        
        //set up the cell
        cell.textLabel!.text = entry.label
        cell.detailTextLabel!.text = entry.url
        
        return cell
    }
    
    //update the search results whenever necessary
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredAcademic.removeAll(keepCapacity: false)
        filterContentForSearchText(searchController.searchBar.text!)
        
        tableView.reloadData()
    }
    
    //the cancel segue. No specific action needed
    @IBAction func cancelToAcademicAppViewController(segue:UIStoryboardSegue) {
    }
    
    //The save segue. Saves it to the current list
    @IBAction func saveAcademicApp(segue:UIStoryboardSegue) {
        if let AcademicAppDetailsViewController = segue.sourceViewController as? AcademicAppDetailsViewController {
            
            //add the new entry to the academic array
            if let entry = AcademicAppDetailsViewController.newEntry {
                academic.append(entry)
                print(entry.label!)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: academic.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON when the cell is clicked
        
        // get correct URL from the selected table cell !!! dont nedd cell only need data
        //let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        
        var entry : Entry
        if resultSearchController.active {
            entry = self.filteredAcademic[indexPath.row]
        } else {
            entry = academic[indexPath.row]
        }
        
        if(!entry.app )
        {
            
            // fix in refactor - get the data tbe directly in the cell
            let url = NSURL(string: (entry.url)!)
            
            // Change the URL with your URL Scheme
            if UIApplication.sharedApplication().canOpenURL(url!) == true
            {
                UIApplication.sharedApplication().openURL(url!)
            }
        }
        else
        {
            
            let url = NSURL(string: ("http://itunes.com/apps/"+entry.developerName!+"/"+entry.appName!))
            
            //!!! open in store
            // Change the URL with your URL Scheme
            if UIApplication.sharedApplication().canOpenURL(url!) == true
            {
                UIApplication.sharedApplication().openURL(url!)
            }
            
        }
    }

}
