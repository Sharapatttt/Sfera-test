//
//  SecondTableViewCell.swift
//  Timer
//
//  Created by Sharapat Azamat on 8/29/21.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    var name: String? {
        didSet {
            guard let name = name else { return }
            nameLabel.text = name
        }
    }
    
    var time: Double? {
        didSet {
            guard let time = time else { return }
            let minute: Int = Int(time) / 60
            let second = Int(time) %  60
            if minute > 9 {
                if second > 9 {
                    timerLabel.text = "\(minute):\(second)"
                } else {
                    timerLabel.text = "\(minute):0\(second)"
                }
            } else {
                if second > 9 {
                    timerLabel.text = "0\(minute):\(second)"
                } else {
                    timerLabel.text = "0\(minute):0\(second)"
                }
            }
        }
    }
// MARK: - UI Components
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ConfigUI
extension SecondTableViewCell {
    func configUI() {
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        backgroundColor = .clear
        
        [nameLabel, timerLabel, lineView].forEach {
            addSubview($0)
        }
        
        makeConstraints()
    }
    
    func makeConstraints() {
        nameLabel.snp.makeConstraints { m in
            m.top.left.equalToSuperview().offset(16)
            m.bottom.equalToSuperview().offset(-16)
        }
        
        timerLabel.snp.makeConstraints { m in
            m.centerY.equalToSuperview()
            m.right.equalToSuperview().offset(-16)
        }
        
        lineView.snp.makeConstraints { (m) in
            m.height.equalTo(1)
            m.bottom.equalToSuperview()
            m.left.equalToSuperview().offset(16)
            m.right.equalToSuperview()
        }
    }
}
