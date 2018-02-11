//
//  ChartCell.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/10.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

class ChartCell: NSManagedObject {
    @NSManaged var number: Double
    @NSManaged var createDate: Date
    
    static func insert(into context: NSManagedObjectContext, number: Double, item: ChartItem) -> ChartCell {
        let cell: ChartCell = context.insertObject()
        cell.number = number
        cell.createDate = Date()
        cell.item = item
        return cell
    }
    
    @NSManaged var item: ChartItem
}

extension ChartCell: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createDate), ascending: false)]
    }
}
