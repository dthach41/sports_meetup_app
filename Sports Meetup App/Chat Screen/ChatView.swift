//
//  ChatView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/6/24.
//

import UIKit

class ChatView: UIView {
    var labelChat: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelChat()
        
        initConstraints()
    }
    
    
    func setupLabelChat() {
        labelChat = UILabel()
        labelChat.text = "Chat"
        labelChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelChat)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelChat.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelChat.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
