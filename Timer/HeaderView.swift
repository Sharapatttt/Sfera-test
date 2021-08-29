//
//  HeaderView.swift
//  Timer
//
//  Created by Sharapat Azamat on 8/29/21.
//

import UIKit

class HeaderView: UIView {

    var title: String? {
        didSet {
            guard let title = title else { return }
            titleLabel.text = title
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ConfigUI
extension HeaderView {
    func configUI() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        
        [titleLabel, lineView].forEach {
            addSubview($0)
        }
        
        makeConstraints()
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { (m) in
            m.top.left.bottom.equalToSuperview().inset(16)
            m.right.lessThanOrEqualTo(-16)
        }
        
        lineView.snp.makeConstraints { (m) in
            m.right.left.equalToSuperview()
            m.height.equalTo(1)
            m.bottom.equalToSuperview()
        }
    }
}
