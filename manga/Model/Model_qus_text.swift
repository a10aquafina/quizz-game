//
//  Model_qus_text.swift
//  manga
//
//  Created by Apple on 05/09/2021.
//


import Foundation
import SQLite3
import SQLite.Swift

class Model_qus_text:NSObject
{
    var id: Int = 0
    var level: String = ""
    var ques: String = ""
    var ans1: Blob = Blob(bytes: [0])
    var ans2: Blob = Blob(bytes: [0])
    var ans3: Blob = Blob(bytes: [0])
    var ans4: Blob = Blob(bytes: [0])
    
   
    
    init(id: Int,level:String, ques:String, ans1:Blob,ans2:Blob,ans3:Blob,ans4:Blob ){
        self.id = id
        self.level = level
        self.ques = ques
        self.ans1 = ans1
        self.ans2 = ans2
        self.ans3 = ans3
        self.ans4 = ans4
        
    }
}
