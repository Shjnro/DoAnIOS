//
//  EmployeeTableViewController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class EmployeeTableViewController: UITableViewController {

    //MARK: Properties
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Create an example of meal
        if let employee = Employee(name: "Nguyen Van A", id: "123", gioiTinh: "Nam", ngaySinh: "31/05/2023", email: "admin@gmail.com", phone: "08237283286", diaChi: "abcd") {
            employees += [employee]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employees.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "EmployeeTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? EmployeeTableViewCell {
            // Do du lieu vao cell
            let employee = employees[indexPath.row]
            cell.lblId.text = employee.getId()
            cell.lblName.text = employee.getName()
            cell.lblEmail.text = employee.getEmail()
            cell.lblGioiTinh.text = employee.getGioiTinh()
            cell.lblNgaySinh.text = employee.getNgaySinh()
            cell.lblPhone.text = employee.getPhone()
            cell.lblDiaChi.text = employee.getDiaChi()
            return cell
        }
        //issue error
        fatalError("Khong the tao cell!")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    @IBAction func unWindFromMealDetailController(segue:UIStoryboardSegue) {
        //print("Quay ve tu MealDetailController")
        
        // Lay meal tu man hinh MealDetailController
        if let source = segue.source as? EmployeeViewController {
            if let employee = source.employee {
                //print("Mon an truyen ve la: \(meal.getName())")
                switch source.navigationType {
                case .newEmployee:
                    // Ghi vao co so du lieu
                    //                    let _ = dao.insert(meal: meal)
                    //Tinh toan vi tri cua mon an moi trong tableView
                    let newIndexPath = IndexPath(row: employees.count, section: 0)
                    employees += [employee]
                    tableView.insertRows(at:[newIndexPath], with: .none)
                case .editEmployee:
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        employees[seclectedIndexPath.row] = employee
                        tableView.reloadRows(at: [seclectedIndexPath], with: .none)
                    }
                }
            }
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Lay destination de truyen vao tham so
        if let destination = segue.destination as? EmployeeViewController{
            // Xac dinh tao mon an moi hay edit mon an
            if let segueName = segue.identifier {
                if segueName == "newEmployee"{
                    //                    print(segueName)
                    destination.navigationType = .newEmployee
                }
                else {
                    //print("Edit mon an cu")
                    destination.navigationType = .editEmployee
                    
                    //Lay indexpath cua save duoc chon
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        destination.employee = employees[seclectedIndexPath.row]
                    }
                }
            }
        }
    }
}
