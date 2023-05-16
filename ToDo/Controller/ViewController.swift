//
//  ViewController.swift
//  ToDo
//
//  Created by Saruar on 09.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let CoreDataModel = CoreDataManager()
    let cellSpacingHeight: CGFloat = 5
    
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
     

        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        
        view.addSubview(tableView)
        

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        CoreDataModel.getAllItems()
        return CoreDataModel.tasks.count
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let task = CoreDataModel.tasks[indexPath.section]
            CoreDataModel.deleteItem(item: task)
            CoreDataModel.getAllItems()
            
            tableView.beginUpdates()
        
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            
            
            tableView.endUpdates()
        }
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = CoreDataModel.tasks[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath)
        
        cell.textLabel?.text = task.tasks
        
        
//        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//        cell.clipsToBounds = true
       
  
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 25, height: 25))
        imageView.backgroundColor = .clear
        
        
        if task.isSelected == true{

            imageView.image =  UIImage(systemName: "checkmark.circle.fill")
            
            
        }else{
            
            imageView.image =  UIImage(systemName: "checkmark.circle")
           
            
            
        }
        
        cell.accessoryView = imageView

        return cell
    }
    
  
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let task = CoreDataModel.tasks[indexPath.section]
        
        
        if task.isSelected == true{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.backgroundColor = .clear
            imageView.image =  UIImage(systemName: "checkmark.circle.fill")
            cell?.accessoryView = imageView
            
            CoreDataModel.updateItem(item: task, newIsSelect: false)
            
            print("3")
            
        }else{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.backgroundColor = .clear
            imageView.image =  UIImage(systemName: "checkmark.circle")
            cell?.accessoryView = imageView
            
            CoreDataModel.updateItem(item: task, newIsSelect: true)
            
            print("4")
            
        }
        
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}


