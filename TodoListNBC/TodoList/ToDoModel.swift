//
//  toDoModel.swift
//  TodoList
//
//  Created by David Jang on 3/23/24.
//

import Foundation

struct ToDoModel {
    let id: UUID
    let title: String
    var isCompleted: Bool
    let date: Date

    init(title: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
        self.date = Date()
    }
}

