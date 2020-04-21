//
//  Model.swift
//  HIKEAPPCP
//
//  Created by Joshua Storey on 4/20/20.
//  Copyright © 2020 ASU. All rights reserved.
//

import UIKit
import CoreData

public class Model {
    let managedObjectContext : NSManagedObjectContext?
    init(context : NSManagedObjectContext) {
        managedObjectContext = context
    }
    func fetchRecord() -> Array<HikeEntity> {
           // Create a new fetch request using the FruitEntity
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HikeEntity")
           let sort = NSSortDescriptor(key: "name", ascending: true)
           fetchRequest.sortDescriptors = [sort]
           var x   = 0
           // Execute the fetch request, and cast the results to an array of FruitEnity objects
           var fetchResults = ((try? managedObjectContext!.fetch(fetchRequest)) as? [HikeEntity])!
           
           
          
           
           
           // return howmany entities in the coreData
                return fetchResults
           
           
       }
    
    
    func SaveContext(name: String, distance: String, time: String) {
           let ent = NSEntityDescription.entity(forEntityName: "HikeEntity", in: self.managedObjectContext!)
                  //add to the manege object context
                  let newItem = HikeEntity(entity: ent!, insertInto: self.managedObjectContext)
                  newItem.name =  name
                  newItem.distance = distance
                    newItem.time = time
                  newItem.picture = nil
           do {
               try managedObjectContext!.save()
               print("Hike Added")
           } catch let error {
               print(error.localizedDescription)
           }
           
           
       }

   
}
