//
//  SalaryTableViewCell.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/30/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class SalaryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPart: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
