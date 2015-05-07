//
//  UserDao.swift
//  sqliteDemo
//  用户数据库操作
//  Created by mo on 15-4-16.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import Foundation
let userDao:UserDao = UserDao()
class UserDao:BaseDB{
    
    class func getInstance()->UserDao{
        return userDao
    }	
    
    func createUserTable(){
        super.createTable(createSQL: "CREATE TABLE IF NOT EXISTS USER (NAME TEXT PRIMARY KEY,PASSWORD TEXT,AGE TEXT);")
    }
    
    func addUser(user:UserModel)->Bool{
        var sql:String = "INSERT INTO USER(NAME,PASSWORD,AGE) VALUES(?,?,?)"
        var param:NSArray = NSArray(objects:user.name!,user.password!,user.age!)
        return super.dealData(dealSQL: sql,params: param)
    }
    
    
    func findUser()->NSArray{
        var sql:String = "SELECT NAME,PASSWORD,AGE FROM USER"
        var data:NSArray = super.selectData(selectSQL: sql, columnCount: 3)
        
        var result:NSMutableArray = NSMutableArray()
        
        for(var i=0;i<data.count;i++){
            var name:String = data[i].objectAtIndex(0) as String
            var password:String = data[i].objectAtIndex(1) as String
            var age:String = data[i].objectAtIndex(2) as String
            var user = UserModel()
            user.name = name
            user.password = password
            user.age = age
            result.addObject(user)
        }
        
        return result
    }
    
}