//
//  CreateGroupViewController.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/10.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class CreateGroupViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                let group = try ChartGroup.insert(into: self.managedObjectContext, groupName: name)
                let banner = NotificationBanner(title: "\(group.name)分组创建成功", subtitle: nil, style: .success)
                banner.duration = 1.0
                banner.show()
                self.navigationController?.popViewController(animated: true)
            } catch {
                if case ManagedObjectError.objectExist(let object) = error {
                    if let group = object as? ChartGroup {
                        let banner = NotificationBanner(title: "\(group.name)分组已存在", subtitle: "请重新输入分组名称", style: .danger)
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

extension CreateGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
