//
//  ViewController.swift
//  Charting
//
//  Created by daqian zeng on 23/01/2018.
//  Copyright © 2018 daqian zeng. All rights reserved.
//

import UIKit
import CoreData
import SwiftDate

extension UIViewController {
    var managedObjectContext: NSManagedObjectContext {
        get {
            return CoreDataManager.share.persistentContainer.viewContext
        }
    }
}

extension Date {
    
    enum GCPDateStyle: String {
        case yyyyMMdd
        case yyyyMMddHHmmss
        case HHmm
        var formatString: String {
            get {
                switch self {
                case .yyyyMMdd:
                    return "yyyy-MM-dd"
                case .yyyyMMddHHmmss:
                    return "yyyy-MM-dd HH:mm:ss"
                case .HHmm:
                    return "HH:mm"
                }
            }
        }
    }
    
    func string(for style: GCPDateStyle) -> String? {
        return string(custom: style.formatString)
    }
    
    func preaty() -> String? {
        if self.isToday {
            return string(for: .HHmm)
        } else if self.isYesterday {
            return "昨天"
        } else if self > Date().startWeek {
            return self.weekdayName
        } else {
            return string(for: .yyyyMMdd)
        }
    }
    
}
