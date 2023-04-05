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

class CategoryController: UIViewController{
    
    let realm = try! Realm()
    
    
    var categoryItems: Results<Category>?
    
    let tableView = UITableView().then{
        $0.register(Cell.tableViewCell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loadItem()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        BarCustom()
        layout()
    }
}

extension CategoryController{
    func layout(){
        
        tableView.rowHeight = 80.0
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
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
extension CategoryController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = ViewController()
        destinationVC.selectedCategory = categoryItems![indexPath.row]
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}

//MARK: - TableView DataSource
extension CategoryController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryItems?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(Cell.tableViewCell) else {return UITableViewCell()}
        cell.delegate = self
        cell.textLabel?.text = categoryItems?[indexPath.row].name ?? "No Categories"
        
        return cell
    }
}

//MARK: - SwipeCell Delegate
extension CategoryController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let categoryForDeletion = self.categoryItems?[indexPath.row]{
                do{
                    
                    try self.realm.write{
                        self.realm.delete(categoryForDeletion)
                    }
                }catch{
                    print("Error, \(error)")
                }
                
                //tableView.reloadData()
            }
           
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive

        return options
    }
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
