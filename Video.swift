//
//  Video.swift
//  witOrbit
//
//  Created by Gul Mehru on 1/30/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit


class Cell: NSObject {
    var groupName: String?
}


class Video: NSObject {
    var thumbNailImageName: String?
    var profileImageName: String?
    var title: String?
    var textMessage: String?
    var subTitleView: String?
    var channel: Channel?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var name: String?
    
}

class Channel: NSObject {
    

}

