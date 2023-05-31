//
//  MealTableViewController.swift
//  FoodManagement2023
//
//  Created by CNTT on 5/4/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    //MARK: Properties
    private var mealList = [Meal]()
    private var dao:DatabaseLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Them btnEdit
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Khoi tao doi tuong co so du lieu dao
        dao = DatabaseLayer()
        
        //Doc du lieu tu database vao mealList
        dao.getAllMeal(meals: &mealList)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Tao mon an gia
//        if let monAn = Meal(name: "Mon hue", ratingValue: 2, imgMeal: UIImage(named: "default")){
//            mealList += [monAn]
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mealList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = "MealTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? MealTableViewCell {
            // Do du lieu vao cell
            let meal = mealList[indexPath.row]
            cell.lblMealName.text = meal.getName()
            cell.ratingControl.ratingValue = meal.getRatingValue()
            cell.imgMeal.image = meal.getimgMeal()
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
            mealList.remove(at: indexPath.row)
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
        if let source = segue.source as? MealDetailController {
            if let meal = source.meal {
                //print("Mon an truyen ve la: \(meal.getName())")
                switch source.navigationType {
                case .newMeal:
                    // Ghi vao co so du lieu
                    let _ = dao.insert(meal: meal)
                    //Tinh toan vi tri cua mon an moi trong tableView
                    let newIndexPath = IndexPath(row: mealList.count, section: 0)
                    mealList += [meal]
                    tableView.insertRows(at:[newIndexPath], with: .none)
                case .editMeal:
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        mealList[seclectedIndexPath.row] = meal
                        tableView.reloadRows(at: [seclectedIndexPath], with: .none)
                    }
                }
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //Ham xac dinh duong di chuyen man hinh
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("Chuyen man hinh")
        //Lay destination de truyen vao tham so
        if let destination = segue.destination as? MealDetailController{
            // Xac dinh tao mon an moi hay edit mon an
            if let segueName = segue.identifier {
                if segueName == "newMeal"{
                    //print("Tao mon an moi")
                    destination.navigationType = .newMeal
                }
                else {
                    //print("Edit mon an cu")
                    destination.navigationType = .editMeal
                    
                    //Lay indexpath cua save duoc chon
                    if let seclectedIndexPath = tableView.indexPathForSelectedRow {
                        destination.meal = mealList[seclectedIndexPath.row]
                    }
                }
            }
        }
    }
}
