//
//  ViewController.swift
//  ToDo
//
//  Created by Saruar on 09.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let customCell = CustomCell()
    let CoreDataModel = CoreDataManager()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        createTable()
        createNavButton()
        CoreDataModel.getAllItems()
        
        title = "ToDo"

     



    }
    
    
    

    

    
    //MARK: - Navigation Controller
    
    func createNavButton(){
        let addTaskBarButton = UIBarButtonItem(title: "Add task", style: .done, target: self, action: #selector(addTask))
        self.navigationItem.rightBarButtonItem  = addTaskBarButton
    }
    
    //MARK: - Alert Controller
    @objc func addTask(){
        let alert = UIAlertController(title: "Add Task", message: "Input your task", preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.CoreDataModel.createItem(name: String(textField!.text!))
            
            
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
    
    
    //MARK: - TableView

    func createTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.backgroundColor = UIColor(red: 0.30, green: 0.30, blue: 0.43, alpha: 1.00)

      
        
        view.addSubview(tableView)
        

    }
    


    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let task = CoreDataModel.tasks[indexPath.row]
            
            
            CoreDataModel.deleteItem(item: task)
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = CoreDataModel.tasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath)
        
        cell.textLabel?.text = task.tasks
        
        
        if task.isSelected{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.backgroundColor = .clear
            imageView.image =  UIImage(systemName: "checkmark.circle.fill")
            cell.accessoryView = imageView
            
        }else{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.backgroundColor = .clear
            imageView.image =  UIImage(systemName: "checkmark.circle")
            cell.accessoryView = imageView
            task.isSelected = true
            
        }
        
        

        
        
        
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let task = CoreDataModel.tasks[indexPath.row]
        
        
        if task.isSelected == true{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.backgroundColor = .clear
            imageView.image =  UIImage(systemName: "checkmark.circle.fill")
            cell?.accessoryView = imageView
            task.isSelected = false
            
            print("3")
            
        }else{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.backgroundColor = .clear
            imageView.image =  UIImage(systemName: "checkmark.circle")
            cell?.accessoryView = imageView
            task.isSelected = true
            
            print("4")
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    


}

