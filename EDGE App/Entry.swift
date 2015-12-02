//
//  Entry.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/2/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import Foundation

class Entry {
    //whether Entry is about Social
    var social : Bool!
    //whether Entry is about Academic
    var academic : Bool!
    //whether Entry is about Wellness
    var wellness : Bool!
    
    //whether it this entry is for an App
    var app : Bool!
    
    //display label to user for entry
    var label : String?
    
    //url to the link data, or page !?!
    //will be custom url if supported. This may be an issue.
    var url : String?
    
    //array of other tags, used for search
    var tags : String?
    
    var developerName : String?
    
    var appName : String?
    
    init(label : String?, url :String? )
    {
        self.social = false
        self.wellness = false
        self.academic = false
        self.app = false
        self.label = label
        self.appName = label
        self.url = url
        self.tags = nil

    }
    
    init(soc: Bool, ac: Bool , well: Bool, app: Bool, label : String?, url :String?, tags : String?)
    {
        social = soc
        wellness = well
        academic = ac
        self.app = app
        self.label = label
        self.url = url
        self.tags = tags
    }
    
    init(soc: Bool, ac: Bool , well: Bool, app: Bool, label : String?, url :String?, tags : String?, devName : String?, appName : String?)
    {
        social = soc
        wellness = well
        academic = ac
        self.app = app
        self.label = label
        self.url = url
        self.tags = tags
        developerName = devName
        self.appName = appName
    }
    
    func search(searchString: String) -> Bool {
        return (tags?.lowercaseString.rangeOfString(searchString.lowercaseString) != nil)
    }
    
    func addTag(tag : String) {
        tags?.appendContentsOf(tag)
    }
    
}
