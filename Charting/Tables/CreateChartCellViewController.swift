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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: ChartItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = datePicker.date.string(for: .yyyyMMdd)
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
            let _ = ChartCell.insert(into: self.managedObjectContext, number: number, date: self.datePicker.date, item: self.item)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        datePicker.isHidden = !datePicker.isHidden
        tableView.endUpdates()
    }

    @IBAction func datepickerValueChanged(_ sender: UIDatePicker) {
        dateLabel.text = datePicker.date.string(for: .yyyyMMdd)
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
