//
//  ChartCellTableViewCell.swift
//  Charting
//
//  Created by daqian zeng on 2018/2/11.
//  Copyright © 2018年 daqian zeng. All rights reserved.
//

import UIKit

class ChartCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(for cell: ChartCell) {
        textLabel?.text = "\(cell.number)"
        detailTextLabel?.text = cell.date.string(for: .yyyyMMdd)
    }
}
