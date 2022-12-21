//
//  Sound_Service.swift
//  manga
//
//  Created by Apple on 19/09/2021.
//

import Foundation
import UIKit
import SQLite

class Sound_Service:NSObject {
    static let shared: Sound_Service = Sound_Service()
    var DatabaseRoot:Connection?
  
    var ListData:[Model_Sound] = [Model_Sound]()
    
    func loadInit(){
        let dbURL = Bundle.main.url(forResource: "abc", withExtension: "db")!
        
        var newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        newURL.appendPathComponent("abc.db")
        do {
            if FileManager.default.fileExists(atPath: newURL.path) {
                print("sss")
            }
            try FileManager.default.copyItem(atPath: dbURL.path, toPath: newURL.path)
            print(newURL.path)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            DatabaseRoot = try Connection(newURL.path)
        } catch {
            DatabaseRoot = nil
            let nserr = error as NSError
            print("Cannot connect to Database. Error is: \(nserr), \(nserr.userInfo)")
        }
    }
    
    func getData(closure: @escaping (_ response: [Model_Sound]?, _ error: Error?) -> Void) {
        let users1 = Table("sound")
        let id = Expression<Int>("id")
        let turn = Expression<Int>("turn")
        let vibra = Expression<Int>("vibra")
        
        ListData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    ListData.append(Model_Sound( id: Int(user[id]) ,
                                                 turn: Int(user[turn]) ,
                                                 vibra: Int(user[vibra])
                                                         
                    ))
                }
            } catch  {
            }
        }
        closure(ListData, nil)
        
    }
    
    func updatesound(check: Int,closure: @escaping (_ response: [Model_Sound]?, _ error: Error?) -> Void) {
        let users1 = Table("sound")
        let id = Expression<Int>("id")
        let turn = Expression<Int>("turn")
        let vibra = Expression<Int>("vibra")
        
        ListData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                let alice = users1.filter(id == 1)
                try DatabaseRoot.run(alice.update(turn<-check))
            } catch  {
            }
        }
        closure(ListData, nil)
        
    }
}
