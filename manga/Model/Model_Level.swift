//
//  Model_Level.swift
//  manga
//
//  Created by Apple on 01/09/2021.
//


import Foundation
import SQLite3
import SQLite.Swift

class Model_Level:NSObject
{
    var id: Int = 0
    var type: String = ""
    var img: Blob = Blob(bytes: [0])
    var lock: Int = 0
    
    init(id: Int,type:String, img: Blob, lock:Int ){
        self.id = id
        self.type = type
        self.img = img
        self.lock = lock
        
    }
}
