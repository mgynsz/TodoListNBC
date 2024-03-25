//
//  toDoTableViewCell.swift
//  TodoList
//
//  Created by David Jang on 3/23/24.
//

import UIKit

// 테이블뷰 셀 생성을 위한 페이지
// 스토리보드와 연결 Title / Date / Button

class ToDoTableViewCell: UITableViewCell {
    
    // 셀 재사용 Identifier
    public static let Identifier: String = "ToDoTableViewCell"
    
    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // 완료||미완료 이미지
    private let doImage = UIImage(systemName: "circle")
    private let didImage = UIImage(systemName: "checkmark.circle.fill")
    
    // 셀 업데이트 클로저
    var stateCheckButton: (() -> Void)?
    
    private var todo: ToDoModel! {
        didSet {
            // UI 업데이트
            toDoTitle.text = todo.title
            toDoDate.text = formatDate(todo.date)
            setupCheckButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // 셀이 재사용될 준비가 될 때 호출
    override func prepareForReuse() {
        super.prepareForReuse()
        checkButton.setImage(doImage, for: .normal) // 체크 버튼 이미지를 기본 상태로 설정
    }
    
    public func setTodo(_ todo: ToDoModel) {
        self.todo = todo
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        todo.isCompleted.toggle()
        setupCheckButton()
        stateCheckButton?()
    }
    
    // 체크버튼 이미지 상태
    private func setupCheckButton() -> Void {
        checkButton.setImage(todo.isCompleted ? didImage : doImage, for: .normal)
    }
    
    // 셀 UI 초기 설정
    private func setupUI() -> Void {
        selectionStyle = .none
        checkButton.setTitle("", for: .normal)
    }
    
    // 날짜 포맷 변경 메서드
    private func formatDate(_ date: Date) -> String {
        // 월일시분
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd a hh:mm"
        return dateFormatter.string(from: date)
    }
}
