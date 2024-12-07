//
//  NewMessageTableViewManager.swift
//  Messenger App
//
//  Created by Jack Huang on 11/5/24.
//

import Foundation
import UIKit

extension NewMessageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewSearchResults, for: indexPath) as! SearchTableViewCell
        
        let user = users[indexPath.row]
        cell.labelEmail.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        checkForChat(selectedUser: selectedUser)
    }
}
