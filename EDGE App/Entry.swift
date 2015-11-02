//
//  Entry.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/2/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import Foundation

struct Entry
{
    //whethether Entry is about Socail matters
    var socail : Bool!
    //whether Entry is about acedmic matters
    var acedemic : Bool!
    //whether Entry is about wellness
    var wellness : Bool!
    
    //whether it this entry is for an App
    var app : Bool!
    
    //display label to user for eentry
    var label : String?
    
    //url to the link data, or page !?!
    var url : String?
    
    init(label : String?, url :String? )
    {
        self.socail = false
        self.wellness = false
        self.acedemic = false
        self.app = false
        self.label = label
        self.url = url
    }
    
    init(soc: Bool, ac: Bool , well: Bool, app: Bool, label : String?, url :String? )
    {
        socail = soc
        wellness = well
        acedemic = ac
        self.app = app
        self.label = label
        self.url = url
    }
    
    
}
