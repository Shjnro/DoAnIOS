//
//  JobTableViewCell.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/27/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var lblWork: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
