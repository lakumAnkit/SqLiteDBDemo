//
//  UpdateVc.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 30/07/21.
//

import UIKit

protocol RecordeUpdateDelegate {
    func reloadData()
}

class UpdateVc: UIViewController {
    
    @IBOutlet weak var EmpName: UITextField!
    @IBOutlet weak var EmpSalary: UITextField!
    @IBOutlet weak var EmpDepartment: UITextField!
    @IBOutlet weak var EmpAddress: UITextField!
    
    var delegate: RecordeUpdateDelegate?

    var id:Int = 0
    var db:DBhelper = DBhelper()
    var myList:[Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func UpdateDataInDatabase(_ sender: UIButton) {
        db.updateData(id: id, name: EmpName.text!, salary: Int(EmpSalary.text!)!, department: EmpDepartment.text!, address: EmpAddress.text!)
        print("update from protocol")
        self.delegate?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func OnCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
