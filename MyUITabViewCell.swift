//
//  MyUITabViewCell.swift
//  EDGE App
//
//  Created by Ryan Orlando and Devon Colman on 12/1/15.
//  Copyright © 2015 EDGE IQP Team. All rights reserved.
//  This is the custom UITable View If we ever need one not used as of yet
//

import Foundation
import UIKit

class MyUITabViewCell: UITableViewCell
{
    var data: Entry
    
    override init(style: UITableViewCellStyle,
        reuseIdentifier: String?)
    {
        self.data = Entry(label: "", url: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //!!! dont know if I need to make this intitailizer
    }
    
    func setData(data: Entry)
    {
        self.data = data
        self.textLabel!.text = self.data.label
        self.detailTextLabel!.text = self.data.url
        //!!! think if any think else would need to be done for this
        
    }
}

