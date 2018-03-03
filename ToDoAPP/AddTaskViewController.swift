//
//  AddTaskViewController.swift
//  ToDoAPP
//
//  Created by ZED on 1/17/17.
//  Copyright © 2017 ZED. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var textFeild: UITextField!
    
    @IBOutlet weak var isImportant: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btnPress(_ sender: Any) {
        
        //always write this for context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //put task in Task type whcic is an entitiy
        let task = Task(context: context)
        task.name=textFeild.text!
        task.isImportnt = isImportant.isOn
        
        //save data to core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //when add something it retutn to main menu
        navigationController!.popViewController(animated: true)
        
    }
    
    

}
