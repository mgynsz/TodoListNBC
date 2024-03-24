//
//  ViewController.swift
//  TodoList
//
//  Created by David Jang on 3/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var todos = ToDo.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        
//        if let navigationBar = navigationController?.navigationBar {
//                let textAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)]
//                navigationBar.titleTextAttributes = textAttributes
//            }
        
    }
    
    private func setupUI() -> Void {
        self.title = "ToDo"
        addTodoButton()
    }
    
    func addTodoButton() {
        
        
        let button = UIButton(type: .system)
//        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(showAddTodoAlert), for: .touchUpInside)
        animateButton(button)
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.widthAnchor.constraint(equalToConstant: 60), // 버튼 너비
            button.heightAnchor.constraint(equalToConstant: 60) // 버튼 높이
        ])
        
        animateButton(button)
    }
    
    
    func animateButton(_ button: UIButton) {
        // 버튼 "숨쉬기" 애니메이션
        UIView.animate(withDuration: 3.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
    }
    
    @objc func showAddTodoAlert() {
        let alertController = UIAlertController(title: "새 할 일 추가", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "할 일 제목"
        }
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let title = alertController.textFields?.first?.text, !title.isEmpty else { return }
            self?.addNewTodo(title: title)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func addNewTodo(title: String) {
        // 여기서 `ToDoModel` 인스턴스를 직접 만들어 넘기는 대신,
        // `title`과 `isCompleted`를 넘깁니다.
        todos.addTodo(title: title, isCompleted: false)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.Identifier, for: indexPath) as! ToDoTableViewCell
        let todo = todos.getTodo(indexPath.row)
        cell.setTodo(todo)
        cell.onCompletionToggle = { [weak self] in
            self?.todos.toggleTodoCompletion(index: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.todos.removeTodo(indexPath.item)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68 // 원하는 셀의 높이로 조절
    }
}
