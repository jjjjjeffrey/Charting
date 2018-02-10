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
}

extension ChartCell: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createDate), ascending: false)]
    }
}
