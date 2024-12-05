//
//  UserTableView.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/4/24.
//

import UIKit

class UserTableView: UIView {

    var searchBar: UISearchBar!
    var tableViewSearchUserResults: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSearchBar()
        setupTableViewSearchUserResults()
        
        initConstraints()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search by usernames.."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
    }
    
    func setupTableViewSearchUserResults() {
        tableViewSearchUserResults = UITableView()
        tableViewSearchUserResults.register(UserTableViewCell.self, forCellReuseIdentifier: Configs.tableViewSearchUserResults)
        tableViewSearchUserResults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewSearchUserResults)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableViewSearchUserResults.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableViewSearchUserResults.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableViewSearchUserResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            tableViewSearchUserResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
