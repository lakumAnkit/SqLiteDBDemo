//
//  EmpDetailCell.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 29/07/21.
//

import UIKit

class EmpDetailCell: UITableViewCell {
    
    @IBOutlet weak var EmpID: UILabel!
    @IBOutlet weak var EmpName: UILabel!
    @IBOutlet weak var EmpSalary: UILabel!
    @IBOutlet weak var EmpDepartment: UILabel!
    @IBOutlet weak var EmpAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
