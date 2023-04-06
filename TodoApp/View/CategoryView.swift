//
//  Category.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/05.
//

import UIKit
import SnapKit
import Then
import CoreData
import RealmSwift
import SwipeCellKit

class CategoryController: SwipeTableViewController{
    
    let realm = try! Realm()
    
    
    var categoryItems: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.loadItem()
        tableView.delegate = self
        tableView.dataSource = self
        BarCustom()
    }
    
    
}

extension CategoryController{
    
    func BarCustom(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addButtonPressed))
        self.navigationItem.title = "Category"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
        
    }
    @objc func addButtonPressed(){
        
        var text = UITextField()
        
        let alert =  UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField{
            $0.placeholder = "Create new CategoryName"
            text = $0
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default){_ in
            
            let newCategory = Category()
            newCategory.name = text.text!
            
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}

//MARK: - TableView Delegate
extension CategoryController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = ViewController()
        destinationVC.selectedCategory = categoryItems![indexPath.row]
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}

//MARK: - TableView DataSource
extension CategoryController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryItems?[indexPath.row].name ?? "No Categories"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryItems?.count ?? 1
    }
    
    

}

//MARK: - SwipeCell Delegate
extension CategoryController{
}


extension CategoryController{
    func save(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error")
        }
        tableView.reloadData()
    }
    
    func loadItem(){
        
        self.categoryItems = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}
