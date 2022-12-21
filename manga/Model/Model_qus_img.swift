//
//  Model_qus_img.swift
//  manga
//
//  Created by Apple on 08/09/2021.
//


import Foundation
import SQLite3
import SQLite.Swift

class Model_qus_img:NSObject
{
    var id: Int = 0
    var level: String = ""
    var img: Blob = Blob(bytes: [0])
    var ques: String = ""
    var ans1: String = ""
    var ans2: String = ""
    var ans3: String = ""
    var ans4: String = ""
    
    
   
    
    init(id: Int,level:String,img:Blob, ques:String, ans1:String ,ans2:String,ans3:String,ans4:String){
        self.id = id
        self.level = level
        self.img = img
        self.ques = ques
        self.ans1 = ans1
        self.ans2 = ans2
        self.ans3 = ans3
        self.ans4 = ans4
        
    }
}
