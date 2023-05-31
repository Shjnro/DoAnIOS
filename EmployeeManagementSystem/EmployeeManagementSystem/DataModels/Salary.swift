//
//  Salary.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/30/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import Foundation

class Salary {
    //MARK:Properties
    private var name:String;
    private var part:String;
    private var salary:Int;
    
    //MARK: Contructors
    init?(name:String, part:String, salary:Int) {
        if name.isEmpty {
            return nil
        }
        if part.isEmpty {
            return nil
        }
        if salary < 0 {
            return nil
        }
        // Dua gia tri vao bien thanh phan cua doi tuong
        self.name = name
        self.part = part
        self.salary = salary
    }
    
    // Getter and setter
    public func getName()->String{
        return name
    }
    public func getPart()->String{
        return part
    }
    public func getSalary()->Int{
        return salary
    }
}
