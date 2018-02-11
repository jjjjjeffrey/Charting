//
//  CreateChartCellViewController.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/11.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit

class CreateChartCellViewController: UITableViewController {

    @IBOutlet weak var numberTextField: UITextField!
    
    var item: ChartItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let text = numberTextField.text, text.count > 0, let number = Double(text) else {
            return
        }
        numberTextField.resignFirstResponder()
        self.managedObjectContext.performChanges {
            let _ = ChartCell.insert(into: self.managedObjectContext, number: number, item: self.item)
            self.navigationController?.popViewController(animated: true)
        }
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
