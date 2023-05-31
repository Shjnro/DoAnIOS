//
//  EmployeeViewController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtId: UITextField!
    @IBOutlet weak var edtGioiTinh: UITextField!
    @IBOutlet weak var edtNgaySinh: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPhone: UITextField!
    @IBOutlet weak var edtDiaChi: UITextField!
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    //Dinh nghia bien navigationType
    enum NavigationType {
        case newEmployee
        case editEmployee
    }
    var navigationType:NavigationType = .newEmployee
    
    var employee:Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lay du lieu meal truyen sang tu TableViewController
        if let employee = employee {
            edtId.text = employee.getId()
            edtName.text = employee.getName()
            edtGioiTinh.text = employee.getGioiTinh()
            edtNgaySinh.text = employee.getNgaySinh()
            edtPhone.text = employee.getPhone()
            edtEmail.text = employee.getEmail()
            edtDiaChi.text = employee.getDiaChi()
        }
        
        // Delegation of the TextField
        edtName.delegate = self
        edtId.delegate = self
        edtGioiTinh.delegate = self
        edtNgaySinh.delegate = self
        edtEmail.delegate = self
        edtPhone.delegate = self
        edtDiaChi.delegate = self
    }
    
    //MARK: TextField 'e Delegarion Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("Should return called")
        //ham an ban phim
        edtName.resignFirstResponder()
        edtId.resignFirstResponder()
        edtGioiTinh.resignFirstResponder()
        edtNgaySinh.resignFirstResponder()
        edtEmail.resignFirstResponder()
        edtPhone.resignFirstResponder()
        edtDiaChi.resignFirstResponder()
        return true
    }
    
    //vua ket thuc trinh soan thao thi goi ham nay
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("Did end editing called")
        //lay ten nguoi dung nhap vao edtname
        //print("\(edtMealName.text!)")
        //Cap nhat ten mon an
        //navigationItem.title = edtMealName.text
        
        //Cap nhat trang thai btnSave
        updateSaveState()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSave.isEnabled = false
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        switch navigationType {
        case .newEmployee:
            dismiss(animated: true, completion: nil)
        case .editEmployee:
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func imageProcessing(_ sender: Any) {
        //print("Image view is tapped!")
        
        //An ban phim va lay het qua ten mon an
        edtName.resignFirstResponder()
        // Su dung doi tuong Image Piker Controller de lay anh
        let imagePiker = UIImagePickerController()
        // Cau hinh cho Image Picker Controller
        //sourceType la nguon anh
        imagePiker.sourceType = .photoLibrary
        
        // B3: Thuc hien uy quyen cho doi tuong image picker
        imagePiker.delegate = self
        
        // Hien thi man hinh cua image Picker controller
        present(imagePiker, animated: true, completion: nil)
    }
    

    // B2: Dinh nghia cac ham uy quyen cua doi tuong image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // print("image picker controlled called")
        // Lay anh tu thu vien va dua vao imageview
        // as? la kieu ep kieu nguoc, as la ep kieu
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            employeeImage.image = imageSelected
        }
        // Quay ve man hinh truoc do
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Xac dinh tac nhan chuyen man hinh
        if let btnSender = sender as? UIBarButtonItem {
            if btnSender == btnSave {
                let id = edtId.text ?? ""
                let name = edtName.text ?? ""
                let gioiTinh = edtGioiTinh.text ?? ""
                let ngaySinh = edtNgaySinh.text ?? ""
                let email = edtEmail.text ?? ""
                let phone = edtPhone.text ?? ""
                let diaChi = edtDiaChi.text ?? ""
                
                employee = Employee(name: name, id: id, gioiTinh: gioiTinh, ngaySinh: ngaySinh, email: email, phone: phone, diaChi: diaChi)
            }
        }
        else {
            // Cac truong hop khac
            print("Cac truong hop khong phai UIBarButtonItem")
        }
    }
    
    // MARK: Cap nhat trang thai btnSave
    private func updateSaveState() {
        let id = edtId.text ?? ""
        let name = edtName.text ?? ""
        let gioiTinh = edtGioiTinh.text ?? ""
        let ngaySinh = edtNgaySinh.text ?? ""
        let email = edtEmail.text ?? ""
        let phone = edtPhone.text ?? ""
        let diaChi = edtDiaChi.text ?? ""
        if !id.isEmpty && !name.isEmpty && !gioiTinh.isEmpty && !ngaySinh.isEmpty && !email.isEmpty && !phone.isEmpty && !diaChi.isEmpty {
            // Cho phep btnSave
            btnSave.isEnabled = true
        }
        else {
            // Khong cho phep btnSave
            btnSave.isEnabled = false
        }
    }
}
