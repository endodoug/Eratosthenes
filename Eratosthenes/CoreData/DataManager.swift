//
//  DataManager.swift
//  Eratosthenes
//
//  Created by doug harper on 10/27/17.
//  Copyright © 2017 Doug Harper. All rights reserved.
//

import CoreData

struct CoreDataManager {
  /**
   Initialize a Core Data Stack
   - Parameter name: The name of your Data Model you created.
   - Returns: NSPersistentContainer.
   */
  
  static let shared = CoreDataManager()
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Data Model Name Here")
    container.loadPersistentStores(completionHandler: { (description, err) in
      if let err = err {
        fatalError("☢️ Failed to load store: \(err)")
      }
    })
    return container
  }()
  
}

