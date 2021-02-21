//
//  HeaderView.swift
//  iOSTest
//
//  Created by Adam Israfil on 2/20/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol HeaderViewDelegate: class {

    func backButtonPressed(headerView: HeaderView)
}

class HeaderView: UIView {
    
    var title: String
    var showBackButton: Bool
    
    init(title: String, showBackButton: Bool) {
        self.title = title
        self.showBackButton = showBackButton
        
        super.init(frame: CGRect.zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func backButtonPressed() {
        delegate?.backButtonPressed(headerView: self)
    }
    
    weak var delegate: HeaderViewDelegate?
    
    private var backButton: UIButton!
    
    func setupViews() {
        let header = UIView()
        header.backgroundColor = #colorLiteral(red: 0.0220622886, green: 0.4392663538, blue: 0.6077302694, alpha: 1)
        addSubview(header)
        
        header.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let fontSize: CGFloat = 17
        
        backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "Back Arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.isHidden = !showBackButton
        header.addSubview(backButton)
        
        backButton.snp.makeConstraints {
            $0.height.equalTo(fontSize * 2)
            $0.width.equalTo(fontSize * 2)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: fontSize, weight: .semibold)
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel.numberOfLines = 0
        header.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
        }
    }
}
