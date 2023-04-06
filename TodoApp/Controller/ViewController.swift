//
//  View.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/04.
//

import UIKit
import RealmSwift


//MARK: - TableViewDataSource
extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    

}

//MARK: - TableView Delegate
extension ViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write{
                    item.done = !item.done
                    tableView.reloadData()
                }
            }catch{
                print("Error saving done status, \(error)")
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - SearchBar Delegate

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dataCreated",ascending: true)

        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                //커서와 키보드 제거
                searchBar.resignFirstResponder()
            }

        }
    }
}

//MARK: - load Items
extension ViewController{

    
    func loadItems(){
        self.todoItems = selectedCategory?.items.sorted(byKeyPath: "title",ascending: true)
        tableView.reloadData()
    }
}

