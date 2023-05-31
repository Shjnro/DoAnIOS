//
//  SalaryTableViewController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/30/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class SalaryTableViewController: UITableViewController {

    //MARK: Properties
    var salaryList = [Salary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add Left Bar Itrem Button on the Bar
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Create an example of meal
        if let salary = Salary(name: "Nguyen Van B", part: "Bo Phan A", salary: 7000000) {
            salaryList += [salary]
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return salaryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "SalaryTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? SalaryTableViewCell {
            // Do du lieu vao cell
            let salary = salaryList[indexPath.row]
            cell.lblName.text = salary.getName()
            cell.lblPart.text = salary.getPart()
            cell.lblSalary.text = String(salary.getSalary())
            return cell
        }
        //issue error
        fatalError("Khong the tao cell!")
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            salaryList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

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
        if let source = segue.source as? SalaryController {
            if let salary = source.salary {
                //print("Mon an truyen ve la: \(meal.getName())")
                switch source.navigationType {
                case .newSalary:
                    // Ghi vao co so du lieu
                    //                    let _ = dao.insert(meal: meal)
                    //Tinh toan vi tri cua mon an moi trong tableView
                    let newIndexPath = IndexPath(row: salaryList.count, section: 0)
                    salaryList += [salary]
                    tableView.insertRows(at:[newIndexPath], with: .none)
                case .editSalary:
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        salaryList[seclectedIndexPath.row] = salary
                        tableView.reloadRows(at: [seclectedIndexPath], with: .none)
                    }
                }
            }
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Lay destination de truyen vao tham so
        if let destination = segue.destination as? SalaryController{
            // Xac dinh tao mon an moi hay edit mon an
            if let segueName = segue.identifier {
                if segueName == "newSalary"{
                    //                    print(segueName)
                    destination.navigationType = .newSalary
                }
                else {
                    //print("Edit mon an cu")
                    destination.navigationType = .editSalary
                    
                    //Lay indexpath cua save duoc chon
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        destination.salary = salaryList[seclectedIndexPath.row]
                    }
                }
            }
        }
    }
}
