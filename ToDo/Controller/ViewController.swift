//
//  ViewController.swift
//  ToDo
//
//  Created by Saruar on 09.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 

    
    private var tasks = [ToDoList]()
    
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        let addTaskBarButton = UIBarButtonItem(title: "Add task", style: .done, target: self, action: #selector(addTask))
        self.navigationItem.rightBarButtonItem  = addTaskBarButton
        
        
        getAllItems()
        
        
        title = "ToDo"
    }
    
    @objc func addTask(){
        let alert = UIAlertController(title: "Add Task", message: "Input your task", preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.createItem(name: String(textField!.text!))
            print(self.tasks)
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
        
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let task = tasks[indexPath.row]
            
            deleteItem(item: task)
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("LOL")
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("Hi")
        
        cell.textLabel?.text = task.tasks
        
        return cell
    }
    
    
    
    
    
    //MARK: - CoreDataFunctions
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItems(){
        do{
            tasks = try context.fetch(ToDoList.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }catch{
            print(error)
        }
        
    }
    
    func createItem(name: String){
        
        let newItem = ToDoList(context: context)
        newItem.tasks = name
        newItem.date = Date()
        
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

