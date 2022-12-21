//
//  Ques_text_Service.swift
//  manga
//
//  Created by Apple on 05/09/2021.
//

import Foundation
import UIKit
import SQLite

class Ques_text_Service:NSObject {
    static let shared: Ques_text_Service = Ques_text_Service()
    var DatabaseRoot:Connection?
  
    var ListData:[Model_qus_text] = [Model_qus_text]()
    
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
    
    func getData(closure: @escaping (_ response: [Model_qus_text]?, _ error: Error?) -> Void) {
        let users1 = Table("quiz2")
        let id = Expression<Int>("id")
        let level = Expression<String>("level")
        let ques = Expression<String>("ques")
        let ans1 = Expression<Blob?>("ans1")
        let ans2 = Expression<Blob?>("ans2")
        let ans3 = Expression<Blob?>("ans3")
        let ans4 = Expression<Blob?>("ans4")
        
        ListData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    ListData.append(Model_qus_text( id: Int(user[id]) ,
                                                 level: String(user[level]) ,
                                                 ques: String(user[ques]) ,
                                                 ans1: user[ans1] ?? Blob(bytes: [0]),
                                                 ans2: user[ans2] ?? Blob(bytes: [0]),
                                                 ans3: user[ans3] ?? Blob(bytes: [0]),
                                                 ans4: user[ans4] ?? Blob(bytes: [0])
                                                         
                    ))
                }
            } catch  {
            }
        }
        closure(ListData, nil)
        
    }
}
