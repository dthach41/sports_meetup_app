//
//  NewMessageView.swift
//  Messenger App
//
//  Created by Derek Thach on 11/5/24.
//


import UIKit

class NewMessageView: UIView {
    
    var searchBar: UISearchBar!
    var tableViewSearchResults: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSearchBar()
        setupTableViewSearchResults()
        
        initConstraints()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search emails.."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
    }
    
    func setupTableViewSearchResults() {
        tableViewSearchResults = UITableView()
        tableViewSearchResults.delaysContentTouches = false
        tableViewSearchResults.register(SearchTableViewCell.self, forCellReuseIdentifier: Configs.tableViewSearchResults)
        tableViewSearchResults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewSearchResults)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableViewSearchResults.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableViewSearchResults.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

