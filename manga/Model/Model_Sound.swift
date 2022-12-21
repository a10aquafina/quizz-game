//
//  Model_Sound.swift
//  manga
//
//  Created by Apple on 19/09/2021.
//


import Foundation
import SQLite3
import SQLite.Swift

class Model_Sound:NSObject
{
    var id: Int = 0
    var turn: Int = 0
    var vibra: Int = 0
    
    init(id: Int,turn:Int, vibra:Int ){
        self.id = id
        self.turn = turn
        self.vibra = vibra
        
        
    }
}
