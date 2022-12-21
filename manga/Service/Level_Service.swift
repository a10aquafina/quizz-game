//
//  Level_Service.swift
//  manga
//
//  Created by Apple on 01/09/2021.
//

import Foundation

import UIKit
import SQLite

class Level_Service:NSObject {
    static let shared: Level_Service = Level_Service()
    var DatabaseRoot:Connection?
  
    var ListData:[Model_Level] = [Model_Level]()
    
    func loadInit(){
        let dbURL = Bundle.main.url(forResource: "abc", withExtension: "db")!
        
        var newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        newURL.appendPathComponent("abc.db")
        do {
            if FileManager.default.fileExists(atPath: newURL.path) {
//                print("sss")
            }
            try FileManager.default.copyItem(atPath: dbURL.path, toPath: newURL.path)
//            print(newURL.path)
        } catch {
//            print(error.localizedDescription)
        }
        
        do {
            DatabaseRoot = try Connection(newURL.path)
        } catch {
            DatabaseRoot = nil
            let nserr = error as NSError
//            print("Cannot connect to Database. Error is: \(nserr), \(nserr.userInfo)")
        }
    }
    
    func getData(closure: @escaping (_ response: [Model_Level]?, _ error: Error?) -> Void) {
        let users1 = Table("type2")
        let id = Expression<Int>("id")
        let type = Expression<String>("type")
        let img = Expression<Blob?>("img")
        let lock = Expression<Int>("lock")
        
        ListData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    ListData.append(Model_Level( id: Int(user[id]) ,
                                                type: String(user[type]) ,
                                                img: user[img] ?? Blob(bytes: [0]),
                                                lock: Int(user[lock])
                                                         
                    ))
                }
            } catch  {
            }
        }
        closure(ListData, nil)
        
    }
    
    func update(level :Int  ,closure: @escaping (_ response: [Model_Level]?, _ error: Error?) -> Void) {
        let users1 = Table("type2")
        let id = Expression<Int>("id")
        let type = Expression<String>("type")
        let link = Expression<String>("link")
        let lock = Expression<Int>("lock")

        if let DatabaseRoot = DatabaseRoot{
            do{
                
                let alice = users1.filter(id == level + 1 )
                try DatabaseRoot.run(alice.update(lock <- 1))
                
            }
            catch{
                print("-------1232123")
            }
        closure(ListData, nil)

        }
    }
    
}
