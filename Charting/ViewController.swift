//
//  ViewController.swift
//  Charting
//
//  Created by daqian zeng on 23/01/2018.
//  Copyright © 2018 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var managedObjectContext: NSManagedObjectContext {
        get {
            return CoreDataManager.share.persistentContainer.viewContext
        }
    }
}
