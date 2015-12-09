//
//  WellnessViewController
//  EDGE App
//
//  Created by Devon Coleman on 11/23/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

class WellnessViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var entryObjects: NSMutableArray! = NSMutableArray()
    
    //the array of wellness entries
    var wellness:[Entry] = wellnessData
    
    //the filtered (searched) array
    var filteredWellness = [Entry]()
    
    //the Results Search Controller
    var resultSearchController = UISearchController()
    
    //sets up the search controller and view once it's loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //makes the view take prescedence when swapped to, fixes
        //black screens when searching and changing tabs
        self.definesPresentationContext = true
        
        //the results controller
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        //refresh the tableview
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        fetchAllObjectsFromLocalDatastore()
        print("Fetching Objects")
        fetchAllObjects()
    }
    
    ///updats the Entrty data to sycn it witht ther data being held in the local Database
    func updateData()
    {
        
        //SHoudl clear some how but it is not working !!!
        
        var first: Bool = true;
        for var index = 0; index < entryObjects.count; ++index
        {
            
            let object: PFObject = self.entryObjects.objectAtIndex(index) as! PFObject
            
            let newEntry : Entry = Entry(soc: (object["Social"] as? Bool)!, ac: (object["academic"] as? Bool)!, well: (object["wellness"] as? Bool)!, app: (object["app"] as? Bool)!, label: object["label"] as? String,  url: object["url"] as? String, tags: object["tags"] as? String, devName: object["DeveloperName"] as? String, appName: object["appName"] as? String)
            
            if(first)
            {
                wellness = [newEntry]
                first = false;
            }
            else
            {
                wellness.append(newEntry)
            }
            
            
            print("updating Data" + newEntry.label!)
            
            
            
        }
        
    }
    
    /// Fetch all objects from the Local Database
    func fetchAllObjectsFromLocalDatastore() {
        
        let query: PFQuery = PFQuery(className: "Entry")
        
        query.fromLocalDatastore()
        
        query.whereKey("wellness", equalTo: true)
        
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
        
        //query.whereKey("wellness", equalTo: true)
        
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
        self.filteredWellness = self.wellness.filter({( newApp: Entry ) -> Bool in
            let stringMatch = newApp.label!.lowercaseString.rangeOfString(searchText.lowercaseString)
            let urlMatch = newApp.url!.lowercaseString.rangeOfString(searchText.lowercaseString)
            let tagMatch = newApp.search(searchText)
            return tagMatch || (stringMatch != nil) || (urlMatch != nil) || searchText.isEmpty
        })
    }
    
    //Detects when search is active and prepares the table view accordingly
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let controller = segue.destinationViewController
            let entry: Entry
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                
                //if search is active
                if resultSearchController.active {
                    entry = filteredWellness[indexPath.row]
                } else {
                    entry = wellness[indexPath.row]
                }
                
                controller.title = entry.label
            }
            
            if (self.resultSearchController.active) {
                self.resultSearchController.active = false
            }
        }
    }
    
    //return the number of sections one cell will take up
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //return the correct number of cells depending on which list is active
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return self.filteredWellness.count
        } else {
            return self.wellness.count
        }
    }
    
    //populate the table based on the active list
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("WellnessCell", forIndexPath: indexPath)
        
        let entry: Entry
        if (self.resultSearchController.active) {
            entry = self.filteredWellness[indexPath.row]
        } else {
            entry = self.wellness[indexPath.row]
        }
        
        cell.textLabel!.text = entry.label
        cell.detailTextLabel!.text = entry.url
        
        return cell
    }
    
    //actually update and do the search
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredWellness.removeAll(keepCapacity: false)
        filterContentForSearchText(searchController.searchBar.text!)
        
        tableView.reloadData()
    }
    
    @IBAction func cancelToWellnessAppViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveWellnessApp(segue:UIStoryboardSegue) {
        if let WellnessAppDetailsViewController = segue.sourceViewController as? WellnessAppDetailsViewController {
            
            //add the new player to the players array
            if let entry = WellnessAppDetailsViewController.newEntry {
                wellness.append(entry)
                //SocialViewController.social.append(entry)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: wellness.count-1, inSection: 0)
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
            entry = filteredWellness[indexPath.row]
        } else {
            entry = wellness[indexPath.row]
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
