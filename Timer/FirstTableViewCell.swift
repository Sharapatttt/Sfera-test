//
//  FirstTableViewCell.swift
//  Timer
//
//  Created by Sharapat Azamat on 8/29/21.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    var clickAdd: ((String, Double) -> Void)?
    
    private var nameTimerTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.placeholder = "Название таймера"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    private var timerTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.placeholder = "Время в секундах"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .lightGray
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        [nameTimerTextField, timerTextField, addButton].forEach {
            $0.layer.cornerRadius = 12.0
        }
    }
}

// MARK: - Actions
extension FirstTableViewCell {
    @objc func addTapped() {
        if let clickAdd = clickAdd, let firstText = nameTimerTextField.text, let secondText = timerTextField.text, let time = Double(secondText) {
            clickAdd(firstText, time)
        }
    }
}

// MARK: - ConfigUI
extension FirstTableViewCell {
    func configUI() {
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        backgroundColor = .clear
        
        [nameTimerTextField, timerTextField, addButton].forEach {
            addSubview($0)
        }
        
        makeConstraints()
    }
    
    func makeConstraints() {
        nameTimerTextField.snp.makeConstraints { m in
            m.top.left.equalToSuperview().offset(16)
            m.width.equalTo(UIScreen.main.bounds.width / 2)
            m.height.equalTo(44)
        }
        
        timerTextField.snp.makeConstraints { m in
            m.top.equalTo(nameTimerTextField.snp.bottom).offset(16)
            m.left.equalToSuperview().offset(16)
            m.width.equalTo(UIScreen.main.bounds.width / 2)
            m.height.equalTo(44)
        }
        
        addButton.snp.makeConstraints { m in
            m.top.equalTo(timerTextField.snp.bottom).offset(32)
            m.right.left.equalToSuperview().inset(16)
            m.height.equalTo(60)
            m.bottom.equalToSuperview().offset(-16)
        }
    }
}
