//
//  MainScreenView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit

class MainScreenView: UIView {
    
    var searchBar: UISearchBar!
    var buttonFilterTableView: UIButton!
    var tableViewEvents: UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSearchBar()
        setupButtonFilterTableView()
        setupTableViewEvent()
        
        initConstraints()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search event..."
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
        
    }
    
    func setupButtonFilterTableView() {
        buttonFilterTableView = UIButton(type: .system)
        buttonFilterTableView.setImage(UIImage(systemName:"line.3.horizontal.decrease"), for: .normal)
        buttonFilterTableView.showsMenuAsPrimaryAction = true
        buttonFilterTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonFilterTableView)
    }
    
    func setupTableViewEvent() {
        tableViewEvents = UITableView()
        tableViewEvents.translatesAutoresizingMaskIntoConstraints = false
        tableViewEvents.register(TableViewEventCell.self, forCellReuseIdentifier: "events")
        self.addSubview(tableViewEvents)
    }

    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            buttonFilterTableView.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 4),
            buttonFilterTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonFilterTableView.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            tableViewEvents.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
            tableViewEvents.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewEvents.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewEvents.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

