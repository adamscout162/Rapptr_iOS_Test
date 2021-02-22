//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [Message]?
    private var headerTitle = "Chat"
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages = [Message]()
        configureTable(tableView: chatTable)
        title = headerTitle
        setupViews()
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        DispatchQueue.global(qos: .background).async {
            ChatClient().getChatMessages { (chatMessages) in
                guard let chatMessages = chatMessages else { return }
                self.messages = chatMessages
                
                DispatchQueue.main.async {
                    self.chatTable.reloadData()
                }
            }
        }
    }
    
    // MARK: - Private
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        
        cell?.setCellData(message: messages![indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ChatTableViewCell else { return }
        cell.downloadImage()
    }
    
    // MARK: - IBAction
    func backButtonPressed(headerView: HeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        let header = HeaderView(title: headerTitle, showBackButton: true)
        header.delegate = self
        view.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(64)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        chatTable.allowsSelection = false

        chatTable.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-36)
            $0.top.equalTo(header.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
