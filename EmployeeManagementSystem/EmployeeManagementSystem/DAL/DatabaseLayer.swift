//
//  DatabaseLayer.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import Foundation
import UIKit
import os.log

class DatabaseLayer {
    //MARK: Database's properties
    private let DB_NAME = "jobs.sqlite"
    private let DB_PATH:String?
    private let database:FMDatabase?
    
    //MARK: Tables 's Properties
    //1. Tables jobs
    private let JOB_TABLE_NAME = "jobs"
    private let JOB_ID = "_id"
    private let JOB_WORK = "work"
    private let JOB_DAY = "day"
    private let JOB_TIME = "time"
    private let JOB_NOTE = "note"
    
    //MARK: Contructors
    init() {
        // Lay dia chi thu muc can ghi database
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        // Khoi gan gia tri cho DB_PATH
        DB_PATH = directories[0] + "/" + DB_NAME
        // Khoi tao co so du lieu cho database
        database = FMDatabase(path: DB_PATH)
        // Thong bao su thanh cong khi khoi tao database
        if database != nil {
            os_log("Khoi tao co so du lieu thanh cong")
            // Thuc hien tao cac bang du lieu
            let _ = tablesCreatetion()
        }
        else {
            os_log("Khong the khoi tao co so du lieu")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////
    //MARK: Dinh nghia cac ham primities
    ////////////////////////////////////////////////////////////////////////////////////
    
    //1. Kiem tra su ton tai cua co so du lieu
    private func isDatabaseExist()->Bool {
        return (database != nil)
    }
    
    //2. Ham open
    private func open()->Bool {
        var ok = false
        
        if isDatabaseExist() {
            if database!.open(){
                ok = true
                os_log("Mo co so du lieu thanh cong")
            }
            else {
                os_log("Khong the mo co so du lieu")
            }
        }
        
        return ok
    }
    
    //3. Dong so so du lieu
    private func close()->Bool {
        var ok = false
        
        if isDatabaseExist() {
            if database!.close() {
                ok = true
                os_log("Dong co so du lieu thanh cong")
            }
            else {
                os_log("Khong the dong so so du lieu")
            }
        }
        
        return ok
    }
    
    //4. Ham tao bang
    private func tablesCreatetion()->Bool {
        var ok = false
        
        if open() {
            // Xay dung cau lenh sql
            let sql = "CREATE TABLE \(JOB_TABLE_NAME) ("
                + JOB_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
                + JOB_WORK + " TEXT, "
                + JOB_DAY + " TEXT, "
                + JOB_TIME + " TEXT, "
                + JOB_NOTE + " TEXT)"
            // Thuc thi cau lenh SQL
            if database!.executeStatements(sql) {
                ok = true
                os_log("Tao bang du lieu database thanh cong")
            }
            else {
                os_log("Khong the tao bang co so du lieu")
            }
            
            let _ = close()
        }
        
        return ok
    }
    ////////////////////////////////////////////////////////////////////////////////////
    //MARK: Dinh nghia cac ham APIs
    ////////////////////////////////////////////////////////////////////////////////////
    
    //1. Ghi bien job vao co so du lieu
    public func insert(job:Job)->Bool {
        var ok = false
        
        if open() {
            // cau lenh sql
            let sql = "INSERT INTO \(JOB_TABLE_NAME) (\(JOB_WORK), \(JOB_DAY), \(JOB_TIME), \(JOB_NOTE)) VALUES (?, ?, ?, ?)"
            // Ghi vao co so du lieu
            if database!.executeUpdate(sql, withArgumentsIn: [job.getWork(), job.getDay(), job.getTime(), job.getNote()]){
                ok = true
                os_log("Meal duoc ghi thanh cong vao co so du lieu")
            }
            else {
                os_log("Khong the ghi meal vao co so du lieu")
            }
            let _ = close()
        }
        
        return ok
    }
    //2. Doc toan bo job tu co so du lieu
    public func getAllJobs(jobs: inout [Job]) {
        if open() {
            var result: FMResultSet?
            
            // Cau lenh sql
            let sql = "SELECT * FROM \(JOB_TABLE_NAME) ORDER BY \(JOB_DAY) DESC"
            // Thuc thi cau lenh sql
            // Bat exception
            do {
                // Thuc thi cau lenh
                result = try database!.executeQuery(sql, values: nil)
            }
            catch {
                os_log("Khong the doc meal tu co so du lieu")
            }
            // Xu ly doc du lieu tui database
            if let result = result {
                while (result.next()) {
                    let work = result.string(forColumn: JOB_WORK) ?? ""
                    let day = result.string(forColumn: JOB_DAY) ?? ""
                    let time = result.string(forColumn: JOB_TIME) ?? ""
                    let note = result.string(forColumn: JOB_NOTE) ?? ""
                    // Tao doi tuong job
                    if let job = Job(work: work, day: day, time: time, note: note){
                        // Luu vao tham bien meals
                        jobs.append(job)
                    }
                }
            }
            let _ = close()
        }
    }
    
    //3. Cap nhat job tu co so du lieu
    func updateJob(oldJob: Job, newJob: Job){
        if open() {
            let sql = "UPDATE \(JOB_TABLE_NAME) SET \(JOB_WORK) = ?, \(JOB_DAY) = ?, \(JOB_TIME) = ?, \(JOB_NOTE) = ? WHERE \(JOB_WORK) = ? AND\(JOB_DAY) = ?"
            // Try to query the database
            do{
                try database!.executeUpdate(sql, values: [newJob.getWork(),
                                                          newJob.getDay(), newJob.getTime(), oldJob.getWork(),
                                                          oldJob.getDay()])
                os_log("Successful to update the job!")
            }
            catch{
                print("Fail to update the job:\(error.localizedDescription)")
            }
        }
        else {
            os_log("Database is nil!")
        }
    }
    
    //3. Xoa job tu co so du lieu
    func deleteJob(job: Job){
        if database != nil {
            let sql = "DELETE FROM \(JOB_TABLE_NAME) WHERE \(JOB_WORK) = ? AND\(JOB_TIME) = ?"
            do {
                try database!.executeUpdate(sql, values: [job.getWork(), job.getTime()])
                os_log("The job is deleted!")
            }
            catch {
                os_log("Fail to delete the job!")
            }
        }
        else {
            os_log("Database is nil!")
        }
    }
}

