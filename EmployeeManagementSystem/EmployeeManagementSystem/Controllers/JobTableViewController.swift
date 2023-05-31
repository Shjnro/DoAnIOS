//
//  JobTableViewController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/27/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class JobTableViewController: UITableViewController {

    //MARK: Properties
    private var jobList = [Job]()
    private var dao:DatabaseLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Them btnEdit
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Khoi tao doi tuong co so du lieu dao
        dao = DatabaseLayer()
        
        // Doc du lieu tu database vao mealList
        dao.getAllJobs(jobs: &jobList)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //Tao mon an gia
        if let congViec = Job (work: "aaaa", day: "aaaa", time: "aaaa", note: "aaaa"){
            jobList += [congViec]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "JobTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? JobTableViewCell {
            // Do du lieu vao cell
            let job = jobList[indexPath.row]
            cell.lblWork.text = job.getWork()
            cell.lblDay.text = job.getDay()
            cell.lblTime.text = job.getTime()
            cell.lblNote.text = job.getNote()
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
            //Ghi vao co so du lieu
            let _ = dao.deleteJob(job: jobList[indexPath.row])
            // Delete the row from the data source
            jobList.remove(at: indexPath.row)
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
    // Dinh nghia ham unWind quay ve man hinh detail
    @IBAction func unWindFromMealDetailController(segue:UIStoryboardSegue) {
        //print("Quay ve tu MealDetailController")
        
        // Lay meal tu man hinh MealDetailController
        if let source = segue.source as? JobController {
            if let job = source.job {
                //print("Mon an truyen ve la: \(meal.getName())")
                switch source.navigationType {
                case .newJob:
                    //Ghi vao co so du lieu
                    let _ = dao.insert(job: job)
                    //Tinh toan vi tri cua mon an moi trong tableView
                    let newIndexPath = IndexPath(row: jobList.count, section: 0)
                    jobList += [job]
                    tableView.insertRows(at:[newIndexPath], with: .none)
                case .editJob:
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        //Cap nhat vao co so du lieu
                        let _ = dao.updateJob(oldJob: jobList[seclectedIndexPath.row],
                                              newJob: job)
                        jobList[seclectedIndexPath.row] = job
                        tableView.reloadRows(at: [seclectedIndexPath], with: .none)
                        
                    }
                }
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //Ham xac dinh duong di chuyen man hinh
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Lay destination de truyen vao tham so
        if let destination = segue.destination as? JobController{
            // Xac dinh tao mon an moi hay edit mon an
            if let segueName = segue.identifier {
                if segueName == "newJob"{
//                    print(segueName)
                    destination.navigationType = .newJob
                }
                else {
                    //print("Edit mon an cu")
                    destination.navigationType = .editJob
                    
                    //Lay indexpath cua save duoc chon
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        destination.job = jobList[seclectedIndexPath.row]
                    }
                }
            }
        }
    }
}
