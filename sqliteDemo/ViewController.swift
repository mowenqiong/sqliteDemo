//
//  ViewController.swift
//  sqliteDemo
//  使用sqlite保存和显示数据
//  Created by mo on 15-4-16.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UITableViewDataSource,UITableViewDelegate {
    
    var data:NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData(){
        //查询数据
        var userDao:UserDao = UserDao.getInstance()
        //        userDao.createUserTable()
        //        for(var i=0;i<10;i++){
        //            var user = UserModel()
        //            user.name = "name\(i)"
        //            user.age = "\(i)"
        //            user.password = "123"
        //            userDao.addUser(user)
        //        }
        userDao.createUserTable()
        self.data = userDao.findUser()
        self.tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.data!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
//        }
        var user:UserModel = self.data?.objectAtIndex(indexPath.row) as UserModel
        var nameLabel = cell.viewWithTag(1) as UILabel
        var ageLabel = cell.viewWithTag(2) as UILabel
        nameLabel.text = user.name
        ageLabel.text = user.age
        return cell
    }

    //将用户信息保存到数据库中
//    @IBAction func save(sender: UIButton) {
//        //创建或打开数据库，如果存在则打开，不存在则创建一个数据库
//        var database:COpaquePointer = nil
//        var result = sqlite3_open(NSHomeDirectory().stringByAppendingFormat("/Documents/%@", "data.sqlite"), &database)
//        println(result)
//        if result != SQLITE_OK {
//            sqlite3_close(database)
//            NSLog("创建或打开数据库失败")
//            return
//        }else{
//            NSLog("创建或打开数据库成功")
//        }
//        
//        //创建表
////        let createTableSQL = "CREATE TABLE IF NOT EXISTS FIELDS(ROW INTEGER PRIMARY KEY,FIELD_DATA TEXT);"
////        var errMsg:UnsafeMutablePointer<Int8> = nil
////        result = sqlite3_exec(database, createTableSQL, nil, nil, &errMsg)
////        if result != SQLITE_OK {
////            sqlite3_close(database)
////            NSLog("创建表失败")
////            return
////        }else{
////            NSLog("创建表成功")
////        }
//        
//        //查询数据
//        let querySQL = "SELECT ROW,FIELD_DATA FROM FIELDS ORDER BY ROW"
//        var statement:COpaquePointer = nil
//        result = sqlite3_prepare_v2(database, querySQL, -1, &statement, nil)
//        println(result)
//        if result == SQLITE_OK {
//            //执行查询并遍历返回的数据
//            while sqlite3_step(statement) == SQLITE_ROW {
//                let row = sqlite3_column_int(statement, 0)//获取第一列
//                let rowData = sqlite3_column_text(statement, 1)//获取第二列
//                println(String.fromCString(UnsafePointer<CChar>(rowData)))
//            }
//            //关闭数据库链接，这里每次都是打开链接，用完后就关闭。但是在
//            sqlite3_finalize(statement)
//        }
//        sqlite3_close(database)
//        
//        //插入数据
////        let insertSQL = "INSERT INTO FIELDS(ROW,FIELD_DATA) VALUES (?,?);"
////        var statement:COpaquePointer = nil
////        result = sqlite3_prepare_v2(database, insertSQL, -1, &statement, nil)
////        println(result)
////        if result == SQLITE_OK {
////            sqlite3_bind_int(statement, 1, Int32(1))
////            sqlite3_bind_text(statement, 2, "hello world", -1, nil)
////        }
////        result = sqlite3_step(statement)
////        println(result)
////        if result != SQLITE_DONE {
////            print("插入失败")
////            sqlite3_close(database)
////            return
////        }
////        sqlite3_finalize(statement)
////        sqlite3_close(database)
//        
//    }
//    
//    
}

