//
//  JobController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/27/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class JobController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var edtWork: UITextField!
    @IBOutlet weak var edtDay: UITextField!
    @IBOutlet weak var edtTime: UITextField!
    @IBOutlet weak var edtNote: UITextField!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    //Dinh nghia bien navigationType
    enum NavigationType {
        case newJob
        case editJob
    }
    var navigationType:NavigationType = .newJob
    
    var job:Job?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lay du lieu meal truyen sang tu TableViewController
        if let job = job {
            edtWork.text = job.getWork()
            edtDay.text = job.getDay()
            edtTime.text = job.getTime()
            edtNote.text = job.getNote()
        }
        
        // Cap nhat trang thai btnSave
        updateSaveState()
        
        edtWork.delegate = self
        edtDay.delegate = self
        edtTime.delegate = self
        edtNote.delegate = self
    }
    
    //MARK: TextField 'e Delegarion Function
    // Dinh nghia cac ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("Should return called")
        //ham an ban phim
        edtWork.resignFirstResponder()
        edtDay.resignFirstResponder()
        edtTime.resignFirstResponder()
        edtNote.resignFirstResponder()
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
    
    //MARK: Navigation
    @IBAction func btnCancel(_ sender: Any) {
        switch navigationType {
        case .newJob:
            dismiss(animated: true, completion: nil)
        case .editJob:
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Xac dinh tac nhan chuyen man hinh
        if let btnSender = sender as? UIBarButtonItem {
            if btnSender == btnSave {
                let work = edtWork.text ?? ""
                let day = edtDay.text ?? ""
                let time = edtTime.text ?? ""
                let note = edtNote.text ?? ""
                
                job = Job(work: work, day: day, time: time, note: note)
            }
        }
        else {
            // Cac truong hop khac
            print("Cac truong hop khong phai UIBarButtonItem")
        }
    }
    
    // MARK: Cap nhat trang thai btnSave
    private func updateSaveState() {
        let work = edtWork.text ?? ""
        let day = edtDay.text ?? ""
        let time = edtTime.text ?? ""
        let note = edtNote.text ?? ""
        if !work.isEmpty && !day.isEmpty && !time.isEmpty && !note.isEmpty {
            // Cho phep btnSave
            btnSave.isEnabled = true
        }
        else {
            // Khong cho phep btnSave
            btnSave.isEnabled = false
        }
    }
}
