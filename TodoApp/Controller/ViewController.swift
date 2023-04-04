//
//  View.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/04.
//

import UIKit
import CoreData


//MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeue(Cell.tableViewCell) else  {return UITableViewCell()}
        
        let item = itemArray[indexPath.row]
        
        //Cell title Setting
        cell.textLabel?.text = item.title
        
        //Cell 
        cell.accessoryType = item.done ? .checkmark : .none

        
        return cell
    }
}

//MARK: - TableView Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //데이터 제거
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)

        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Save Items
extension ViewController{
    func saveItems(){
       
        do{
            try context.save()
        }catch{
            print("Error Saving Context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
    }
}

