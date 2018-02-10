//
//  CoreDataManager.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/1.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataManager {
    static let share = CoreDataManager()
    
    fileprivate(set) var persistentContainer: NSPersistentContainer!
    
    private init() {}
    
    static func initialize(_ finished: @escaping () -> ()) {
        share.createContainer { (container) in
            share.persistentContainer = container
            finished()
        }
    }
    
    private func createContainer(completion: @escaping (NSPersistentContainer) -> ()) {
        let container = NSPersistentContainer(name: "Charting")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError("Failed to load store: \(error!)") }
            DispatchQueue.main.async { completion(container) }
        }
    }
}


