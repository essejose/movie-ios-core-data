//
//  CategoriesViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 13/09/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit
import CoreData

enum CategoryAlerType{
    case add, edit
}



class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource : [Category] = []
    var movie  : Movie!
    
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        showAlert(type: .add, category: nil)
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func showAlert(type: CategoryAlerType, category: Category?){
        
        let title = (type == .add) ? " Adcionar": "Fechar"
        
        let alert = UIAlertController(title: "\(title) categoria", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nome da categoria"
            if let name = category?.name{
                textField.text = name
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            
            let category = category ?? Category(context: self.context)
            
            category.name = alert.textFields?.first?.text
            try! self.context.save()
            
           // self.tableView.reloadData()
        
            self.loadCategories()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        loadCategories()
        // Do any additional setup after loading the view.
    }
    
    func loadCategories(){
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            dataSource = try context.fetch(fetchRequest)
            tableView.reloadData()
        }
        catch{
            print(error.localizedDescription)
        }
        
        
    }

    
 

}



extension CategoriesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let category = dataSource[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        cell.accessoryType = .none
        
        if let categories = movie.categories{
        
            if categories.contains(category){
                cell.accessoryType = .checkmark
            }
            
        }
        
        
        return cell
        
        
        
    }
    
 
}



extension CategoriesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = dataSource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)!
        
        if cell.accessoryType == .none{
            cell.accessoryType = .checkmark
            movie.addToCategories(category)
        }else{
        
            movie.removeFromCategories(category)
            cell.accessoryType = .none
            
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Excluir") { (
                action, indexPath) in
                
                let category = self.dataSource[indexPath.row]
                self.context.delete(category)
                try! self.context.save()
            
                self.dataSource.remove(at: indexPath.row)
                
                
                tableView.setEditing(false, animated: true)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
                }
                
                let editAction = UITableViewRowAction(style: .normal, title: "Editar", handler: { (actions, indexPath) in
                    
                    let category = self.dataSource[indexPath.row]
                
                    tableView.setEditing(false, animated: true)
                    self.showAlert(type: .edit, category: category)
                    
                
                
                })
                
                editAction.backgroundColor = .blue
                
                
                
                return [ deleteAction, editAction]
                
                
                
           
            
            
    }
    
}
