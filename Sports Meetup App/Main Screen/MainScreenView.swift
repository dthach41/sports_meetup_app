//
//  MainScreenView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit

class MainScreenView: UIView {
    
    var buttonChat: UIButton!
    var buttonProfile: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonChat()
        setupButtonProfile()
        
        
        initConstraints()
    }
    
    func setupButtonChat() {
        buttonChat = UIButton()
        buttonChat.setTitle("Chat", for: .normal)
        buttonChat.setTitleColor(.systemBlue, for: .normal)
        buttonChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonChat)
    }
    
    func setupButtonProfile() {
        buttonProfile = UIButton()
        buttonProfile.setTitle("Profile", for: .normal)
        buttonProfile.setTitleColor(.systemBlue, for: .normal)
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProfile)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            buttonChat.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            buttonChat.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonProfile.topAnchor.constraint(equalTo: buttonChat.bottomAnchor, constant: 24),
            buttonProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

