//
//  TimeLineChartViewController.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/11.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import Charts
import CoreData

class TimeLineChartViewController: UIViewController {

    var item: ChartItem!
    @IBOutlet weak var chartView: LineChartView!
    
    var fetchedResultsController: NSFetchedResultsController<ChartCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.highlightPerDragEnabled = true
        
        chartView.backgroundColor = .white
        
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
//        xAxis.labelPosition = .topInside
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = false
        xAxis.granularity = 1
//        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = chartView.leftAxis
//        leftAxis.labelPosition = .insideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 2000
        leftAxis.axisMaximum = 3000
        leftAxis.yOffset = 0
        leftAxis.granularity = 10
        leftAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        
//        chartView.animate(xAxisDuration: 2.5)
        
        let predicate = NSPredicate(format: "item = %@", item)
        let request = ChartCell.sortedFetchRequest(with: predicate)
        request.fetchBatchSize = 20
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.share.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try! fetchedResultsController.performFetch()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData() {
        var values: [ChartDataEntry] = []
        guard let section = fetchedResultsController.sections?[0] else { return }
        for i in 0..<section.numberOfObjects {
            let cell = fetchedResultsController.object(at: IndexPath(row: i, section: 0))
            let entry = ChartDataEntry(x: Double(i), y: cell.number)
            print(cell)
            values.append(entry)
        }
        
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.lineWidth = 2.0
        set1.drawCirclesEnabled = true
        set1.drawValuesEnabled = true
        set1.fillAlpha = 0.26
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        chartView.data = data
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

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
