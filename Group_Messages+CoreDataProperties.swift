//
//  Group_Messages+CoreDataProperties.swift
//  witOrbit
//
//  Created by ZainAnjum on 24/02/2018.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//
//

import Foundation
import CoreData


extension Group_Messages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group_Messages> {
        return NSFetchRequest<Group_Messages>(entityName: "Group_Messages")
    }

    @NSManaged public var group_id: Int16
    @NSManaged public var message_group_type: Int16
    @NSManaged public var message_id: Int16
    @NSManaged public var message_text: String?
    @NSManaged public var message_type: Int16
    @NSManaged public var group: Groups?

}
