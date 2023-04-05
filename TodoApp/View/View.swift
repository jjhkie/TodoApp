//
//  ViewController.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/03.
//

import UIKit
import SnapKit
import Then
import CoreData

class ViewController: UIViewController {
    

    var itemArray = [Item]()
    
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    
    let tableView = UITableView().then{
        $0.register(Cell.tableViewCell)
    }
    
    let searchBar = UISearchBar()
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //BarCustom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        BarCustom()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        layout()
    }


}

//MARK: - NavigationBar Setting
extension ViewController{
    func BarCustom(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addButtonTapped))
        self.navigationItem.title = "ToDo"
        self.navigationItem.rightBarButtonItem = addButton
        //navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }
    
    
    @objc func addButtonTapped(){
        
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "",preferredStyle: .alert)
        
        alert.addTextField{ alertTextField in
            alertTextField.placeholder = "Create new Item"
            alertText = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default){action in
            
           
            let newItem = Item(context: self.context)
            newItem.title = alertText.text
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
            
        }
        

        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - ViewController layout

extension ViewController{
    
    
    func layout(){
        [tableView,searchBar].forEach{
            view.addSubview($0)
        }
       
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

