//
//  ToDoItem CRUD.swift
//  ToDo
//
//  Created by Saruar on 11.05.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    
    
    init(){}
    
    
    var tasks = [ToDoList]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItems(){
        do{
            tasks = try context.fetch(ToDoList.fetchRequest())
            
        }catch{
            print(error)
        }
        
    }
    
    func createItem(name: String){
        
        let newItem = ToDoList(context: context)
        newItem.tasks = name
        newItem.date = Date()
        newItem.isSelected = false
        
        do{
            try context.save()
            getAllItems()
        }catch{
            print(error)
        }
    }
    
    func deleteItem(item: ToDoList){
        context.delete(item)
        
        do{
            try context.save()
            getAllItems()
        }catch{
            print(error)
        }
        
        
    }
    
    func updateItem(item: ToDoList, newName: String){
        item.tasks = newName
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    
    
}
