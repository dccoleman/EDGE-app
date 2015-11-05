//
//  Entry.swift
//  EDGE App
//
//  Created by Devon Coleman on 11/2/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import Foundation

class Entry {
    //whether Entry is about Social matters
    var social : Bool!
    //whether Entry is about Academic matters
    var academic : Bool!
    //whether Entry is about Wellness
    var wellness : Bool!
    
    //whether it this entry is for an App
    var app : Bool!
    
    //display label to user for eentry
    var label : String?
    
    //url to the link data, or page !?!
    var url : String?
    
    //array of other tags, used for search
    var tags : [String: Bool]
    
    init(label : String?, url :String? )
    {
        self.social = false
        self.wellness = false
        self.academic = false
        self.app = false
        self.label = label
        self.url = url
        self.tags = [String: Bool]()

    }
    
    init(soc: Bool, ac: Bool , well: Bool, app: Bool, label : String?, url :String? )
    {
        social = soc
        wellness = well
        academic = ac
        self.app = app
        self.label = label
        self.url = url
        self.tags = [String: Bool]()
        if(soc) {
            self.tags.updateValue(true, forKey: "social")
        }
        if(ac) {
            self.tags.updateValue(true, forKey: "academic")
        }
        if(well) {
            self.tags.updateValue(true, forKey: "wellness")
        }

    }
    
    func search(tag: String) -> Bool {
        if(self.tags[tag] != nil || self.tags[tag] == false) {
            return true
        }
        return false
    }
    
}
