//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import SnapKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    var message: Message?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellView()
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        self.message = message
        header.text = message.username
        body.text = message.text
    }
    
    func setupCellView() {
        let container = UIView()
        container.backgroundColor = .clear
        contentView.addSubview(container)
        
        container.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        userAvatar.layer.cornerRadius = userAvatar.frame.height / 2
        container.addSubview(userAvatar)
        
        userAvatar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(36)
            $0.width.equalTo(36)
        }
        
        container.addSubview(userAvatar)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(userAvatar.snp.trailing).offset(7)
        }
        
        let bodyContainer = UIView()
        bodyContainer.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        bodyContainer.layer.cornerRadius = 8
        container.addSubview(bodyContainer)
        
        bodyContainer.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(4)
            $0.leading.equalTo(userAvatar.snp.trailing).offset(7)
            $0.trailing.equalToSuperview().offset(-36)
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        bodyContainer.addSubview(body)
        
        body.numberOfLines = 0
        body.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        body.layer.cornerRadius = 8
        body.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        body.layer.borderWidth = 1.0
        
        body.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func downloadImage() {
        guard let url = message?.avatarURL, userAvatar.image == nil else { return }
        print("Url: \(url)")

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.userAvatar.image = UIImage(data: data!)
            }
        }
    }
}
