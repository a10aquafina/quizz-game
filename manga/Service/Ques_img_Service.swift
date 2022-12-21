//
//  Ques_img_Service.swift
//  manga
//
//  Created by Apple on 08/09/2021.
//

import Foundation
import UIKit
import SQLite

class Ques_img_Service:NSObject {
    static let shared: Ques_img_Service = Ques_img_Service()
    var DatabaseRoot:Connection?
  
    var ListData:[Model_qus_img] = [Model_qus_img]()
    
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
    
    func getData(closure: @escaping (_ response: [Model_qus_img]?, _ error: Error?) -> Void) {
        let users1 = Table("quiz")
        let id = Expression<Int>("id")
        let level = Expression<String>("level")
        let img = Expression<Blob?>("img")
        let ques = Expression<String>("ques")
        let ans1 = Expression<String>("ans1")
        let ans2 = Expression<String>("ans2")
        let ans3 = Expression<String>("ans3")
        let ans4 = Expression<String>("ans4")
        
        ListData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    ListData.append(Model_qus_img( id: Int(user[id]) ,
                                                 level: String(user[level]) ,
                                                 img: user[img] ?? Blob(bytes: [0]),
                                                 ques: String(user[ques]) ,
                                                 ans1: String(user[ans1]) ,
                                                 ans2: String(user[ans2]) ,
                                                 ans3: String(user[ans3]) ,
                                                 ans4: String(user[ans4])
                                                 
                                                         
                    ))
                }
            } catch  {
            }
        }
        closure(ListData, nil)
        
    }
}
