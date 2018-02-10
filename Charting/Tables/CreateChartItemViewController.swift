//
//  CreateItemViewController.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/10.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class CreateChartItemViewController: UITableViewController {
    
    var group: ChartGroup!

    @IBOutlet weak var nameTextField: UITextField!
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
    
    @IBAction func editingDidEnd(_ sender: Any) {
        guard let name = nameTextField.text, name.count > 0 else {
            return
        }
        self.managedObjectContext.performChanges {
            do {
                let item = try ChartItem.insert(into: self.managedObjectContext, itemName: name, group: self.group)
                let banner = NotificationBanner(title: "\(item.name)数据集创建成功", subtitle: nil, style: .success)
                banner.duration = 1.0
                banner.show()
                self.navigationController?.popViewController(animated: true)
            } catch {
                if case ManagedObjectError.objectExist(let object) = error {
                    if let item = object as? ChartItem {
                        let banner = NotificationBanner(title: "\(item.name)数据集已存在", subtitle: "请重新输入数据集名称", style: .danger)
                        banner.duration = 1.0
                        banner.show()
                    }
                }
            }
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

extension CreateChartItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
