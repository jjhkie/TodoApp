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
import RealmSwift

class ViewController: SwipeTableViewController {
    

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    
    
    let searchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //BarCustom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
       
        let myView = UIView()
        myView.backgroundColor = .red
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1)
        }
        
        view.layoutIfNeeded()
        
        BarCustom()
        //searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do{
               try realm.write{
                    realm.delete(item)
                }
            }catch{
                print("delete Item---  ,\(error)")
            }
        }
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
            
           
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = alertText.text ?? ""
                        newItem.dataCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("error, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        

        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - ViewController layout

extension ViewController{
    
    
    func layout(){
        [searchBar].forEach{
            view.addSubview($0)
        }
       
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

    }
}

