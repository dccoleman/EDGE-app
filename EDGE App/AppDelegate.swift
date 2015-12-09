//
//  AppDelegate.swift
//  EDGE App
//
//  Created by Ryan Orlando and Devon Colman on 10/27/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // This is where we pull from Parse and build the internal lists from the XML files on parse
        
        //aplicaiton ID
        //D1QWo1Xoc5or1fvDTZ7HxqUqgpBSmwEof0KFTEFL
        
        //client ID
        //yAOc37PTxACvZXsjuGideCDZThLcurGDtH8QMCpv
        
        //let parse handle local stuff
        Parse.enableLocalDatastore();
        
        //set Ids that will be used for this aplication
        Parse.setApplicationId("D1QWo1Xoc5or1fvDTZ7HxqUqgpBSmwEof0KFTEFL", clientKey: "yAOc37PTxACvZXsjuGideCDZThLcurGDtH8QMCpv")
        
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        return true
    }



}

