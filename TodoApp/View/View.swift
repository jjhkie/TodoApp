//
//  ViewController.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/03.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    

    var itemArray = [TodoItem]()
    
    let tableView = UITableView().then{
        $0.register(Cell.tableViewCell)
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        loadItems()
    
        
        BarCustom()
        tableView.dataSource = self
        tableView.delegate = self
        layout()
    }


}

//MARK: - NavigationBar Setting
extension ViewController{
    func BarCustom(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addButtonTapped))
        navigationController?.navigationBar.topItem?.title = "ToDo"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
        
    }
    
    
    @objc func addButtonTapped(){
        
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "",preferredStyle: .alert)
        
        alert.addTextField{ alertTextField in
            alertTextField.placeholder = "Create new Item"
            alertText = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default){action in
            
            let newItem = TodoItem()
            newItem.title = alertText.text ?? ""
            
            self.itemArray.append(newItem)
            
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
            
            
            self.tableView.reloadData()
        }
        

        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - ViewController layout

extension ViewController{
    
    
    func layout(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

