//
//  Employee.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class Employee {
    private var name:String
    private var id:String
    private var gioiTinh:String
    private var ngaySinh:String
    private var email:String
    private var phone:String
    private var diaChi:String
    
    //MARK: Contructors
    init?(name:String, id:String, gioiTinh:String, ngaySinh:String, email:String, phone:String, diaChi:String) {
        if name.isEmpty {
            return nil
        }
        if id.isEmpty {
            return nil
        }
        if gioiTinh.isEmpty {
            return nil
        }
        if ngaySinh.isEmpty {
            return nil
        }
        if email.isEmpty {
            return nil
        }
        if phone.isEmpty {
            return nil
        }
        if diaChi.isEmpty {
            return nil
        }
        // Dua gia tri vao bien thanh phan cua doi tuong
        self.name = name
        self.id = id
        self.gioiTinh = gioiTinh
        self.ngaySinh = ngaySinh
        self.email = email
        self.phone = phone
        self.diaChi = diaChi
    }
    
    // Getter and setter
    public func getName()->String{
        return name
    }
    public func getId()->String{
        return id
    }
    public func getGioiTinh()->String{
        return gioiTinh
    }
    public func getNgaySinh()->String{
        return ngaySinh
    }
    public func getEmail()->String{
        return email
    }
    public func getPhone()->String{
        return phone
    }
    public func getDiaChi()->String{
        return diaChi
    }
}
