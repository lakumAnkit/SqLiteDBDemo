//
//  EmployeeDetailVC.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 29/07/21.
//

import UIKit


class EmployeeDetailVC: UIViewController {
    
    @IBOutlet weak var EmpDetailTable: UITableView!
    
    var db:DBhelper = DBhelper()
    var myList:[Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        EmpDetailTable.register(UINib(nibName: "EmpDetailCell", bundle: nil), forCellReuseIdentifier: "EmpDetailCell")
        fetchdata()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        print("view appeared")
        fetchdata()
    }
    
    @IBAction func DeleteAllDataFromDatabase(_ sender: UIButton) {
        self.db.deletAll()
        fetchdata()
    }
    
    @objc func UpdateTable(notification:Notification){
        EmpDetailTable.reloadData()
    }
    
    func fetchdata() {
        myList = db.readData()
        EmpDetailTable.reloadData()
    }

}

extension EmployeeDetailVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpDetailCell") as! EmpDetailCell
        let mydata = myList[indexPath.row]
        cell.EmpID.text = "ID : " + String(mydata.Id)
        cell.EmpName.text = "NAME : " + mydata.Name
        cell.EmpSalary.text = "SALARY : " + String(mydata.Salary)
        cell.EmpDepartment.text = "DEPARTMENT : " + mydata.Department
        cell.EmpAddress.text = "ADDRESS : " + mydata.Address
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateVc") as! UpdateVc
            VC.view.backgroundColor = .clear
            VC.delegate = self
            VC.id = self.myList[indexPath.row].Id
            VC.EmpName.text = self.myList[indexPath.row].Name
            VC.EmpSalary.text = String(self.myList[indexPath.row].Salary)
            VC.EmpAddress.text = self.myList[indexPath.row].Address
            VC.EmpDepartment.text = self.myList[indexPath.row].Department
            self.navigationController?.present(VC, animated: true, completion: nil)
            
        })
        editAction.backgroundColor = UIColor.blue

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("indexPath => \(indexPath.row)")
            
            self.db.deleteByID(id: Int32(self.myList[indexPath.row].Id))
                self.fetchdata()
        })
        deleteAction.backgroundColor = UIColor.red

        return [editAction, deleteAction]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
extension EmployeeDetailVC:RecordeUpdateDelegate{
    func reloadData() {
        self.fetchdata()
    }
}
extension Notification.Name{
    static let updateTable = Notification.Name("updateTable")
}

