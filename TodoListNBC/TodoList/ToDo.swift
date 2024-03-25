//
//  ToDo.swift
//  TodoListNBC
//
//  Created by David Jang on 3/25/24.
//

import Foundation


// 싱글톤으로 인스턴스를 생성!
// ToDoModel 배열에 인스턴스를 만들고, 지우고, 상태를 관리하는 함수가 필요!

class ToDo {
    
    static var instance: ToDo = ToDo()
    private var todos: [ToDoModel] = []

    private init() {}
    
    // 완료 상태 토글
    func toggleCheckButton(index: Int) {
        todos[index].isCompleted.toggle()
    }
    
    public static func getInstance() -> ToDo {
        _ = ToDo.instance.getTodos()
        return instance
    }
    
    func getTodos() -> [ToDoModel] {
        return todos
    }
    
    func count() -> Int {
        todos.count
    }
    
    func getTodo(_ index: Int) -> ToDoModel {
        return todos[index]
    }
    
    func removeTodo(_ index: Int) -> Void {
        todos.remove(at: index)
    }
    
    func addTodo(title: String, isCompleted: Bool) {
        let newTodo = ToDoModel(title: title, isCompleted: isCompleted)
        todos.append(newTodo)
    }
}
