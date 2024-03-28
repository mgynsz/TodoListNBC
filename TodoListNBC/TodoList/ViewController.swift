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
        setupTableView()
        setupUI()
    }
    
    private func setupUI() -> Void {
        self.title = "ToDo"
        addButton()
    }
    
    private func addButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 30
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        addButtonAlignment(button)
        button.addTarget(self, action: #selector(showAddTodoAlert), for: .touchUpInside)
        animateButton(button)
    }
    
    // addButton 오토레이아웃 설정
    private func addButtonAlignment(_ button: UIButton) {
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // addButton 애니메이션
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 3.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
    }
    
    // 새 할일 추가 Alert
    @objc func showAddTodoAlert() {
        let alertController = UIAlertController(title: "🔥 할 일 추가 🔥", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
        }
        
        let saveAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            guard let title = alertController.textFields?.first?.text, !title.isEmpty else { return }
            self?.addNewTodo(title: title)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func addNewTodo(title: String) {
        todos.addTodo(title: title, isCompleted: false)
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 셀 갯수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count()
    }
    
    // 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.Identifier, for: indexPath) as! ToDoTableViewCell
        let todo = todos.getTodo(indexPath.row)
        
        cell.setTodo(todo)
        cell.stateCheckButton = { [weak self] in
            self?.todos.toggleCheckButton(index: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    // 셀 삭제 액션
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.todos.removeTodo(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


