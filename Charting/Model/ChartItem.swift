//
//  ChartItem.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/10.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

class ChartItem: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var createDate: Date
    
    static func insert(into context: NSManagedObjectContext, itemName: String, group: ChartGroup) throws -> ChartItem {
        let predicate = NSPredicate(format: "name == %@ AND group == %@", itemName, group)
        
        guard let existItem = findOrFetch(in: context, matching: predicate) else {
            let item: ChartItem = context.insertObject()
            item.name = itemName
            item.createDate = Date()
            item.group = group
            return item
        }
        throw ManagedObjectError.objectExist(existItem)
    }
    
    @NSManaged var group: ChartGroup
}

extension ChartItem: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createDate), ascending: false)]
    }
}
