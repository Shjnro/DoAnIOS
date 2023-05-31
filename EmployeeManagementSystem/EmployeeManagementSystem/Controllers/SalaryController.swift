//
//  SalaryController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/30/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class SalaryController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtPart: UITextField!
    @IBOutlet weak var edtDay: UITextField!
    @IBOutlet weak var edtViolate: UITextField!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    //Dinh nghia bien navigationType
    enum NavigationType {
        case newSalary
        case editSalary
    }
    var navigationType:NavigationType = .newSalary
    
    var salary:Salary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lay du lieu meal truyen sang tu TableViewController
        if let salary = salary {
            edtName.text = salary.getName()
            edtPart.text = salary.getPart()
        }
        
        // Delegation of the TextField
        edtName.delegate = self
        edtDay.delegate = self
        edtPart.delegate = self
        edtViolate.delegate = self
    }
    

    // MARK: - Navigation
    // Dinh nghia cac ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //ham an ban phim
        edtName.resignFirstResponder()
        edtDay.resignFirstResponder()
        edtPart.resignFirstResponder()
        edtViolate.resignFirstResponder()
        return true
    }
    
    //vua ket thuc trinh soan thao thi goi ham nay
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("Did end editing called")
        //lay ten nguoi dung nhap vao edtname
        //print("\(edtMealName.text!)")
        // Cap nhat ten mon an
        //        navigationItem.title = edtMealName.text
        // Cap nhat trang thai btnSave
        updateSaveState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSave.isEnabled = false
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        switch navigationType {
        case .newSalary:
            dismiss(animated: true, completion: nil)
        case .editSalary:
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Xac dinh tac nhan chuyen man hinh
        if let btnSender = sender as? UIBarButtonItem {
            if btnSender == btnSave {
                let name = edtName.text ?? ""
                let day = Int(edtDay.text ?? "") ?? 0
                let part = edtPart.text ?? ""
                let violate = Int(edtViolate.text ?? "") ?? 0
                let sumSalary = 70000000 - 70000000 * (day + violate) * 5 / 100
                
                salary = Salary(name: name, part: part, salary: sumSalary)
            }
        }
        else {
            // Cac truong hop khac
            print("Cac truong hop khong phai UIBarButtonItem")
        }
    }
    
    // MARK: Cap nhat trang thai btnSave
    private func updateSaveState() {
        let name = edtName.text ?? ""
        let day = edtDay.text ?? ""
        let part = edtPart.text ?? ""
        let violate = edtViolate.text ?? ""
        if !name.isEmpty && !day.isEmpty && !part.isEmpty && !violate.isEmpty {
            // Cho phep btnSave
            btnSave.isEnabled = true
        }
        else {
            // Khong cho phep btnSave
            btnSave.isEnabled = false
        }
    }
}
