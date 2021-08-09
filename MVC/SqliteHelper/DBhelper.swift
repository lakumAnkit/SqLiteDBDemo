//
//  DBhelper.swift
//  SqliteDatabaseDemo
//
//  Created by vishal lakum on 29/07/21.
//

import Foundation
import SQLite3

class DBhelper{
    var db : OpaquePointer?
    var path:String = "myDb.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        
        let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var database : OpaquePointer? = nil
        
        if sqlite3_open(filepath.path, &database) != SQLITE_OK{
            print("error in creating Database")
            return nil;
        }else{
            print("your Database created succes full")
            return database
        }
    }
    
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS employeeDetail(Id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,salary INTEGER,department TEXT,address TEXT);"
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, createTableString, -1, &createTable, nil) == SQLITE_OK{
            if sqlite3_step(createTable) == SQLITE_DONE{
                 print("Table is created succes full")
            }else{
                print("Table is not created")
            }
        }else{
            print("error in table creation ")
        }

    }
    func insertData(id:Int = 1,name:String,salary:Int,department:String,address:String) {
        
//        var id = 1
//        let emp = readData()
//
//        for e in emp
//        {
//            if e.Id == id
//            {
//                id = id + 1
//            }
//        }
//
        let insertQuery = "INSERT INTO employeeDetail(id,name,salary,department,address) VALUES (?,?,?,?,?)"
        
        var insertStatement:OpaquePointer? = nil
                
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK  {
            
//            sqlite3_bind_int(insertStatement, 1, Int32(1))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(salary))
            sqlite3_bind_text(insertStatement, 4, (department as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (address as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Data inserted succes fully")
            }else{
                print("Data not inserted")
            }

        }else{
            print("insert query is not as per requirement")
        }
    }
    
    func readData() -> [Employee]{
        let readQuery = "SELECT * FROM employeeDetail;"
        var readStatement:OpaquePointer? = nil
        var empDetails : [Employee] = []
        
        if sqlite3_prepare_v2(db, readQuery, -1, &readStatement, nil) == SQLITE_OK  {
            while sqlite3_step(readStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(readStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(readStatement, 1)))
                let salary = Int(sqlite3_column_int(readStatement, 2))
                let department = String(describing: String(cString: sqlite3_column_text(readStatement, 3)))
                let address = String(describing: String(cString: sqlite3_column_text(readStatement, 4)))
                
                let model = Employee(id: id, name: name, salary: salary, department: department, address: address)
                
                empDetails.append(model)
                
            }
        }else{
            print("read query is not as per requirement")
        }
        
        return empDetails;
    }
    
    func deleteByID(id:Int32) {
        let deleteQuery = "DELETE FROM employeeDetail WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, id)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
                print(id)
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func deletAll(){
        let deleteAllQuery = "DELETE FROM employeeDetail;"
        var deleteAllStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteAllQuery, -1, &deleteAllStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteAllStatement) == SQLITE_DONE {
                print("Successfully deleted all data.")
            } else {
                print("Could not delete data.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }

    }
    func updateData(id:Int,name:String,salary:Int,department:String,address:String){
        let updateQuery = "UPDATE employeeDetail SET id = ?,name = ?,salary = ?,department = ?,address = ? WHERE ID = \(id);"
        var updateStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatement, nil) == SQLITE_OK{
            
            sqlite3_bind_int(updateStatement, 1, Int32(id))
                sqlite3_bind_text(updateStatement, 2, (name as NSString).utf8String, -1, nil)
                sqlite3_bind_int(updateStatement, 3, Int32(salary))
                sqlite3_bind_text(updateStatement, 4, (department as NSString).utf8String, -1, nil)
                sqlite3_bind_text(updateStatement, 5, (address as NSString).utf8String, -1, nil)
                
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("Data update succes fully")
                }else{
                    print("Data not update")
                }

            
        }
        else{
            print("update query is not as per requirement")
        }
    }
}
