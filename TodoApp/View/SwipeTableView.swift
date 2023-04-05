////
////  SwipeTableView.swift
////  TodoApp
////
////  Created by 김진혁 on 2023/04/05.
////
//
//import UIKit
//import SwipeCellKit
//
//class SwipeTableView:UITableViewController,SwipeTableViewCellDelegate{
//
//    
//    var cell: UITableViewCell?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    //MARK:  TableView DataSource
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeue(Cell.tableViewCell) else {return UITableViewCell()}
//        cell.delegate = self
//       
//        return cell
//    }
//    
//    //MARK:  Swipe Delegate
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            
////            if let categoryForDeletion = self.categoryItems?[indexPath.row]{
////                do{
////
////                    try self.realm.write{
////                        self.realm.delete(categoryForDeletion)
////                    }
////                }catch{
////                    print("Error, \(error)")
////                }
////
////                //tableView.reloadData()
////            }
//           
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//
//        return options
//    }
//    
//}
