//
//  ViewController.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 29/07/21.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       print("")
    }
    
    @IBAction func AddEmployee(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func ViewEmployeeDetail(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailVC") as! EmployeeDetailVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

