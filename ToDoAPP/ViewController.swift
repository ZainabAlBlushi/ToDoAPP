//
//  ViewController.swift
//  ToDoAPP
//
//  Created by ZED on 1/17/17.
//  Copyright © 2017 ZED. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tasks : [Task] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource=self
        tableView.delegate=self
        
    }
    
    //this fucntion for show the data when the table view is load or appear
    
    override func viewWillAppear(_ animated: Bool) {
        //get the data form core data
        getData()
        
        //reload the table view
        tableView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        if task.isImportnt{
            cell.textLabel?.text = " 😟 \(task.name!)"
        }
        else{
        //make the cell text to the name attribiute in core data
        cell.textLabel?.text = task.name!
        }
        return cell
    }
    
    //fetch data from core data
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //always put it in do and try
        do{
        tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("fetching failed")
        }
    }
    
    //delete 
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            
            //after delete we want to save
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //and the again fetch the data
        
            do{
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("fetching failed")
            }
            
            
        }
        
        tableView.reloadData()
        
    }

}

