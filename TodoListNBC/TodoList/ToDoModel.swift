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

class ToDo {
    
    private static var instance: ToDo? // 싱글턴 인스턴스를 저장할 변수
    private var todos: [ToDoModel]
    
    private init() { // 생성자를 private으로 설정
        todos = [
            ToDoModel(title: "첫 번째 할일"),
            ToDoModel(title: "두 번째 할일"),
            ToDoModel(title: "세 번째 할일")
        ]
    }
    
    func toggleTodoCompletion(index: Int) {
        todos[index].isCompleted.toggle()
    }
    
    public static func getInstance() -> ToDo {
        if instance == nil {
            instance = ToDo()
        }
        return instance!
    }
    
    public func getTodos() -> [ToDoModel] {
        return todos
    }
    
    public func count() -> Int {
        todos.count
    }
    
    public func getTodo(_ index: Int) -> ToDoModel {
        return self.todos[index]
    }
    
    public func removeTodo(_ index: Int) -> Void {
        self.todos.remove(at: index)
    }
    
    
    
    
}
extension ToDo {
    func addTodo(title: String, isCompleted: Bool) {
        let newTodo = ToDoModel(title: title, isCompleted: isCompleted)
        todos.append(newTodo)
    }
}

extension ToDo {
    // 할 일의 완료 상태를 토글하고, 배열을 다시 정렬하는 메소드
    func toggleTodoCompletionAndReorder(_ index: Int) {
        // 할 일의 완료 상태를 토글
        todos[index].isCompleted.toggle()

        // 완료된 할 일과 완료되지 않은 할 일로 배열을 분리한 다음 다시 합침
        let completedTodos = todos.filter { $0.isCompleted }
        let incompleteTodos = todos.filter { !$0.isCompleted }
        
        // 다시 합친 배열을 todos에 할당
        todos = incompleteTodos + completedTodos
        
        // 필요한 경우, 여기서 테이블 뷰를 새로고침하는 등의 추가 작업을 수행
    }
}


