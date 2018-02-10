//
//  ItemTableViewCell.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/10.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit

class ChartItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(for item: ChartItem) {
        textLabel?.text = item.name
        detailTextLabel?.text = item.createDate.string(for: .yyyyMMddHHmmss)
    }
}
