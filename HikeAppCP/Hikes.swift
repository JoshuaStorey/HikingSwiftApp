//
//  Hikes.swift
//  HikeAppCP
//
//  Created by Joshua Storey on 4/20/20.
//  Copyright © 2020 Joshua Storey. All rights reserved.
//

import Foundation
import CoreData

public class Hikes : NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var distance : String?
    @NSManaged public var time : String?
    @NSManaged public var picture : NSData?
    
}
