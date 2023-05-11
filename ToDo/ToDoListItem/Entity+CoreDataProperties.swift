//
//  Entity+CoreDataProperties.swift
//  ToDo
//
//  Created by Saruar on 11.05.2023.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var tasks: String?
    @NSManaged public var date: Date?

}

extension ToDo : Identifiable {

}
