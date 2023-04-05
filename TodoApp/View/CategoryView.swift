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

class CategoryController: UIViewController{
    
    var categoryItems = [Category]()
    
    let tableView = UITableView().then{
        $0.register(Cell.tableViewCell)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            
            let newItem = Category(context: self.context)
            newItem.name = text.text
            self.categoryItems.append(newItem)
            
            self.saveItem()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}

//MARK: - TableView Delegate
extension CategoryController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = ViewController()
        destinationVC.selectedCategory = categoryItems[indexPath.row]
        
        navigationController?.pushViewController(destinationVC, animated: true)
        //show(destinationVC, sender: true)
    }
    
    
}

//MARK: - TableView DataSource
extension CategoryController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(Cell.tableViewCell) else {return UITableViewCell()}
        
        cell.textLabel?.text = categoryItems[indexPath.row].name
        
        return cell
    }
}


extension CategoryController{
    func saveItem(){
        do{
            try context.save()
        }catch{
            print("Error")
        }
        tableView.reloadData()
    }
    
    func loadItem(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryItems = try context.fetch(request)
        }catch{
            print("Error")
        }
        
        tableView.reloadData()
    }
}
