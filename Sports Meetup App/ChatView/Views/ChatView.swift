//
//  ChatView.swift
//  Messenger App
//
//  Created by Jack Huang on 11/4/24.
//

import UIKit

class ChatView: UIView {

    var tableViewMessages: UITableView!
    var textfieldMessage: UITextField! // textView
    var buttonSend: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupTableViewMessages()
        setupTextFieldMessage()
        setupButtonSend()
        
        initConstraints()
    }
    
    func setupTableViewMessages() {
        tableViewMessages = UITableView()
        tableViewMessages.register(SenderTableViewCell.self, forCellReuseIdentifier: Configs.tableViewSenderID)
        tableViewMessages.register(ReceiverTableViewCell.self, forCellReuseIdentifier: Configs.tableViewReceiverID)
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewMessages)
    }
    
    func setupTextFieldMessage() {
        textfieldMessage = UITextField()
        textfieldMessage.placeholder = "Message"
        textfieldMessage.borderStyle = .roundedRect
        textfieldMessage.layer.borderWidth = 1
        textfieldMessage.layer.borderColor = UIColor.lightGray.cgColor
        textfieldMessage.clipsToBounds = true
        textfieldMessage.autocapitalizationType = .none
        textfieldMessage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldMessage)
    }
    
    func setupButtonSend() {
        buttonSend = UIButton(type: .system)
        buttonSend.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSend)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableViewMessages.bottomAnchor.constraint(equalTo: textfieldMessage.topAnchor, constant: -10),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            textfieldMessage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            textfieldMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textfieldMessage.trailingAnchor.constraint(lessThanOrEqualTo: buttonSend.leadingAnchor, constant: -5),
            
            buttonSend.leadingAnchor.constraint(lessThanOrEqualTo: textfieldMessage.trailingAnchor, constant: 5),
            buttonSend.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            buttonSend.centerYAnchor.constraint(equalTo: textfieldMessage.centerYAnchor),
            buttonSend.widthAnchor.constraint(equalToConstant: 20),
            buttonSend.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
