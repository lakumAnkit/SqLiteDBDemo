//
//  AddEmployeeVC.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 29/07/21.
//

import UIKit

class AddEmployeeVC: UIViewController {

    @IBOutlet weak var EmpName: UITextField!
    @IBOutlet weak var EmpSalary: UITextField!
    @IBOutlet weak var EmpDepartment: UITextField!
    @IBOutlet weak var EmpAddress: UITextField!
    
    var db:DBhelper = DBhelper()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddEmployee(_ sender: UIButton) {
        db.insertData(name: EmpName.text!, salary: Int(EmpSalary.text!)!, department: EmpDepartment.text!, address: EmpAddress.text!)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailVC") as! EmployeeDetailVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
}
