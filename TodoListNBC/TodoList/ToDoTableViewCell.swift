//
//  toDoTableViewCell.swift
//  TodoList
//
//  Created by David Jang on 3/23/24.
//

import UIKit

// UITableViewCell을 상속받는 ToDoTableViewCell 클래스 정의
class ToDoTableViewCell: UITableViewCell {
    
    // 셀 재사용 식별자
    public static let Identifier: String = "ToDoTableViewCell"
    
    // Interface Builder에서 연결된 UI 컴포넌트들
    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // 할 일 완료 상태에 따라 사용될 이미지
    private let doImage = UIImage(systemName: "circle")
    private let didImage = UIImage(systemName: "checkmark.circle.fill")
    
    // 셀의 완료 상태가 변경될 때 호출될 클로저
    var onCompletionToggle: (() -> Void)?
    
    private var todo: ToDoModel! {
        didSet {
            // 할 일 데이터가 설정되면 UI를 업데이트
            toDoTitle.text = todo.title
            self.setupCheckButton()
            
            // 날짜
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd"
            toDoDate.text = dateFormatter.string(from: todo.date)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setTodo(_ todo: ToDoModel) {
        self.todo = todo
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        todo.isCompleted.toggle()
        self.setupCheckButton()
//        onCompletionToggle?()
    }
    
    private func updateTitleAppearance() {
        // 완료 상태에 따라 취소선을 추가하거나 기본 텍스트로 되돌립니다.
        let attributeString = NSMutableAttributedString(string: todo.title)
        if todo.isCompleted {
            // 완료 상태일 때 중간 취소선을 추가합니다.
            attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributeString.length))
        } else {
            // 완료 상태가 아닐 때는 취소선을 제거합니다. 이 경우, attributeString이 이미 기본 텍스트로 설정되어 있으므로,
            // 별도로 취소선을 제거할 필요는 없습니다. 다만, 명확성을 위해 이 주석을 남깁니다.
        }
        toDoTitle.attributedText = attributeString
    }
    
    // 체크 버튼의 이미지 설정과 제목 업데이트
    private func setupCheckButton() -> Void {
        checkButton.setImage(todo.isCompleted ? didImage : doImage, for: .normal)
        updateTitleAppearance()
    }
    
    // 셀 UI 초기 설정
    private func setupUI() -> Void {
        selectionStyle = .none
        checkButton.setTitle("", for: .normal)
    }
}
