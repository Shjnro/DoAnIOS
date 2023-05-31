//
//  Job.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/27/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class Job {
    //MARK:Properties
    private var work:String
    private var day:String
    private var time:String
    private var note:String
    
    //MARK: Contructors
    init?(work:String, day:String, time:String, note:String) {
        if work.isEmpty {
            return nil
        }
        if day.isEmpty {
            return nil
        }
        if time.isEmpty {
            return nil
        }
        if note.isEmpty {
            return nil
        }
        // Dua gia tri vao bien thanh phan cua doi tuong
        self.work = work
        self.day = day
        self.time = time
        self.note = note
    }
    
    // Getter and setter
    public func getWork()->String{
        return work
    }
    public func getDay()->String{
        return day
    }
    public func getTime()->String{
        return time
    }
    public func getNote()->String{
        return note
    }
}
