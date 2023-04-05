//
//  Category.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/05.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
