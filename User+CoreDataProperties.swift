//
//  User+CoreDataProperties.swift
//  loginApp
//
//  Created by epismac on 3/10/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
