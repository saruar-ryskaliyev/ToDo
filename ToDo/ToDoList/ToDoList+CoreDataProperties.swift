//
//  ToDoList+CoreDataProperties.swift
//  ToDo
//
//  Created by Saruar on 11.05.2023.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var tasks: String?
    @NSManaged public var date: Date?

}

extension ToDoList : Identifiable {

}
