//
//  AppUser+CoreDataProperties.swift
//  loginApp
//
//  Created by epismac on 3/10/24.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}

extension AppUser : Identifiable {

}
