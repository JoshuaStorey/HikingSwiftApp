//
//  FruitEntity+CoreDataProperties.swift
//  tableViewCoreData
//
//  Created by user on 10/1/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import CoreData


extension HikeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HikeEntity> {
        return NSFetchRequest<HikeEntity>(entityName: "HikeEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var distance: String?
    @NSManaged public var time: String?

    @NSManaged public var picture: NSData?

}
