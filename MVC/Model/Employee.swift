//
//  Employee.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 29/07/21.
//

import Foundation
import UIKit

class Employee{
    
    var Id:Int = 0
    var Name:String = ""
    var Salary:Int = 0
    var Department:String = ""
    var Address:String = ""
    
    init() {
    }
    init(id:Int,name:String,salary:Int,department:String,address:String) {
        self.Id = id
        self.Name = name
        self.Salary = salary
        self.Department = department
        self.Address = address
    }
    
}
