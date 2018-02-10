//
//  GroupsViewController.swift
//  Charting
//
//  Created by daqian zeng on 24/01/2018.
//  Copyright © 2018 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

class GroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CoreDataManager.initialize {
            self.setupTableView()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var dataSource: TableViewDataSource<GroupsViewController>!
    
    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        let request = ChartGroup.sortedFetchRequest
        request.fetchBatchSize = 20
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.share.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = TableViewDataSource(tableView: tableView, cellIdentifier: "GroupTableViewCell", fetchedResultsController: frc, delegate: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GroupsViewController: TableViewDataSourceDelegate {
    func configure(_ cell: GroupTableViewCell, for object: ChartGroup) {
        cell.configure(for: object)
    }
}
