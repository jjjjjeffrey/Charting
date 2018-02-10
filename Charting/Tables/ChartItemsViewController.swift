//
//  ItemsViewController.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/10.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

class ChartItemsViewController: UIViewController {
    
    var group: ChartGroup!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = group.name
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var dataSource: TableViewDataSource<ChartItemsViewController>!
    
    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        let predicate = NSPredicate(format: "group = %@", group)
        let request = ChartItem.sortedFetchRequest(with: predicate)
        request.fetchBatchSize = 20
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.share.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = TableViewDataSource(tableView: tableView, cellIdentifier: "ItemTableViewCell", fetchedResultsController: frc, delegate: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CreateChartItemViewController {
            vc.group = group
        }
    }
    

}

extension ChartItemsViewController: TableViewDataSourceDelegate {
    func configure(_ cell: ChartItemTableViewCell, for object: ChartItem) {
        cell.configure(for: object)
    }
}
