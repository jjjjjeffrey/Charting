//
//  ChartCellsViewController.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/11.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import CoreData

class ChartCellsViewController: UIViewController {
    
    var item: ChartItem!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = item.name
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var dataSource: TableViewDataSource<ChartCellsViewController>!
    
    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        let predicate = NSPredicate(format: "item = %@", item)
        let request = ChartCell.sortedFetchRequest(with: predicate)
        request.fetchBatchSize = 20
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.share.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = TableViewDataSource(tableView: tableView, cellIdentifier: "ChartCellTableViewCell", fetchedResultsController: frc, delegate: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CreateChartCellViewController {
            vc.item = item
        } else if let vc = segue.destination as? TimeLineChartViewController {
            vc.item = item
        }
    }
    

}

extension ChartCellsViewController: TableViewDataSourceDelegate {
    func configure(_ cell: ChartCellTableViewCell, for object: ChartCell) {
        cell.configure(for: object)
    }
}
