//
//  Users.swift
//  RealmPart2
//
//  Created by IwasakIYuta on 2021/07/15.
//

import Foundation
import RealmSwift

class Users : Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var age: Int16 = 0
    @objc dynamic var email: String = ""
    convenience init(email: String){
        self.init()
        self.email = email
    }
    override static func primaryKey() -> String? {
        return "email"
    }
    
    
}
