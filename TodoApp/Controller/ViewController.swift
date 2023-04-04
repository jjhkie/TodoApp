//
//  View.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/04.
//

import UIKit


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
        print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Save Items
extension ViewController{
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([TodoItem].self, from: data)
            }catch{
                print("error")
            }
        }
    }
}

