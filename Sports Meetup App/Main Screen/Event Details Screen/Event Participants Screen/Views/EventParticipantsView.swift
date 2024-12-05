//
//  EventParticipantsView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 12/5/24.
//

import UIKit

class EventParticipantsView: UIView {
    
    var tableViewParticipants: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupTableViewParticipants()
        
        initConstraints()
    }
    
    func setupTableViewParticipants() {
        tableViewParticipants = UITableView()
        tableViewParticipants.translatesAutoresizingMaskIntoConstraints = false
        tableViewParticipants.register(ParticipantTableViewCell.self, forCellReuseIdentifier: "participants")
        self.addSubview(tableViewParticipants)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewParticipants.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewParticipants.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            tableViewParticipants.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewParticipants.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
