//
//  MainScreenView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit

class MainScreenView: UIView {
    
    var tableViewEvents: UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewEvent()
        
        initConstraints()
    }
    
    func setupTableViewEvent() {
        tableViewEvents = UITableView()
        tableViewEvents.translatesAutoresizingMaskIntoConstraints = false
        tableViewEvents.register(TableViewEventCell.self, forCellReuseIdentifier: "events")
        self.addSubview(tableViewEvents)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewEvents.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewEvents.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewEvents.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewEvents.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

