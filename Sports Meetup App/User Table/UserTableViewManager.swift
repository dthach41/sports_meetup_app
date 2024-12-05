//
//  UserTableViewManager.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/4/24.
//

import Foundation
import UIKit

extension UserTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewSearchUserResults, for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        
        if let url = URL(string: user.profilePic) {
            cell.imageProfilePic.loadRemoteImage(from: url)
        } else {
            cell.imageProfilePic.image = UIImage(systemName: "person.circle.fill")
        }
        cell.labelName.text = user.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        let profileViewController = ProfileViewController()
        profileViewController.userUID = selectedUser.id
        profileViewController.userProfile = selectedUser
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

