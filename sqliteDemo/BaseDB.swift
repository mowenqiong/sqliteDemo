//
//  BaseDB.swift
//  sqliteDemo
//  数据库工具类
//  Created by mo on 15-4-16.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import Foundation
class BaseDB:NSObject{
    
    /**
    接口描述：创建表
    参数：sql：sql语句
    */
    func createTable(createSQL sql:String){
        var database:COpaquePointer = nil
        var result = sqlite3_open(filePath(), &database)
        if result != SQLITE_OK {
            NSLog("打开数据库失败")
            sqlite3_close(database)
            return
        }
        var errorMsg:UnsafeMutablePointer<Int8> = nil
        if sqlite3_exec(database, sql, nil, nil, &errorMsg) != SQLITE_OK {
            NSLog("创建表失败")
            sqlite3_close(database)
            return
        }
        sqlite3_close(database)
    }
    
    
    /**
     接口描述：增加,修改,删除
     参数：sql：sql语句
          params：参数
     返回值：是否执行成功
    */
    func dealData(dealSQL sql:String,params:NSArray)->Bool{
        var database:COpaquePointer = nil
        var statement:COpaquePointer = nil
        if sqlite3_open(filePath(), &database) != SQLITE_OK {
            NSLog("打开数据库失败")
            sqlite3_close(database)
            return false
        }
        
        if sqlite3_prepare_v2(database, sql, -1, &statement, nil) != SQLITE_OK {
            NSLog("SQL语句编译失败")
            sqlite3_close(database)
            return false
        }
        
        //绑定数据
        //在设计数据库时字段设计为字符串类型
        for(var i=0;i<params.count;i++){
            var value:NSString = params.objectAtIndex(i) as NSString
            sqlite3_bind_text(statement, i+1, value.UTF8String, -1, nil)
        }
        var result = sqlite3_step(statement)
        println(result)
        if  result == SQLITE_ERROR {
            NSLog("SQL语句执行失败")
            sqlite3_close(database)
            return false
        }
        sqlite3_finalize(statement)
        sqlite3_close(database)
        return true
    }
    
    
    /**
    接口描述：查询
    参数：sql：sql语句
        columnCount:字段个数
    返回值：查询结果
          [
            ["字段值1","字段值2","字段值3"],
            ["字段值1","字段值2","字段值3"]
          ]
    */
    func selectData(selectSQL sql:String,columnCount:Int)->NSMutableArray{
        var database:COpaquePointer = nil
        var statement:COpaquePointer = nil
        var result:NSMutableArray = NSMutableArray()
        if sqlite3_open(filePath(), &database) != SQLITE_OK {
            NSLog("打开数据库失败")
            sqlite3_close(database)
            return result
        }
        if sqlite3_prepare_v2(database, sql, -1, &statement, nil) != SQLITE_OK {
            NSLog("SQL语句编译失败")
            sqlite3_close(database)
            return result
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            var row:NSMutableArray = NSMutableArray(capacity:columnCount)
            for(var i:Int = 0; i<columnCount; i++) {
                var value = sqlite3_column_text(statement, Int32(i))
                row.addObject(String.fromCString(UnsafePointer<CChar>(value))!)
            }
            result.addObject(row)
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(database)
        
        return result
    }
    
    //数据库文件路径
    func filePath()->String{
        return NSHomeDirectory().stringByAppendingFormat("/Documents/%@", "data.sqlite")
    }
    
}