//
//  ChartObject.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/1.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

class ChartGroup: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var createDate: Date
    
    static func insert(into context: NSManagedObjectContext, groupName: String) throws -> ChartGroup {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(name), groupName)
        guard let existGroup = findOrFetch(in: context, matching: predicate) else {
            let group: ChartGroup = context.insertObject()
            group.name = groupName
            group.createDate = Date()
            return group
        }
        throw ManagedObjectError.objectExist(existGroup)
    }
}

extension ChartGroup: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createDate), ascending: false)]
    }
}

enum ManagedObjectError: Error {
    case objectExist(NSManagedObject)
}
