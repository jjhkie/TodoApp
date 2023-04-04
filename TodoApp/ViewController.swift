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
    
    let defaults = UserDefaults.standard

    var itemArray = ["FInd Mike","Buy Eggs","Destory Demogorgon"]
    
    let tableView = UITableView().then{
        $0.register(Cell.tableViewCell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
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
        
        let action = UIAlertAction(title: "Add Item", style: .default){action in
            self.itemArray.append(alertText.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField{ alertTextField in
            alertTextField.placeholder = "Create new Item"
            alertText = alertTextField
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


//MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(Cell.tableViewCell) else  {return UITableViewCell()}
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
}

//MARK: - TableView Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

