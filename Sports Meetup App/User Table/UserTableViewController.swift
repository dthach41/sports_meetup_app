//
//  UserTableViewController.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/4/24.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class UserTableViewController: UIViewController {
    
    let userTableView = UserTableView()
    let db = Firestore.firestore()

    var listTitle: String = ""
    var userIDs = [String]()
    var users = [User]()
    var usernamesForTableView = [String]()
    
    override func loadView() {
        view = userTableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = listTitle
        
        userTableView.searchBar.delegate = self
        
        userTableView.tableViewSearchUserResults.delegate = self
        userTableView.tableViewSearchUserResults.dataSource = self
    }
    
    func fetchUsers() {
//        let userCollection = db.collection("users")
//        
//        let userDispatchGroup = DispatchGroup()
//        
//        for uid in userIDs {
//            userDispatchGroup.enter()
//            userCollection.document(uid).getDocument { snapshot, error in
//                if let error = error {
//                    print("Error fetching user: \(error.localizedDescription)")
//                } else if let snapshot = snapshot, snapshot.exists,
//                          let user = try? snapshot.data(as: User.self) {
//                    self.users.append(user)
//                    self.usernamesForTableView.append(user.name)
//                }
//                userDispatchGroup.leave()
//            }
//        }
//        
//        userDispatchGroup.notify(queue: .main) {
//            self.userTableView.tableViewSearchUserResults.reloadData()
//        }
        guard !userIDs.isEmpty else { return }
        db.collection("users").whereField(FieldPath.documentID(), in: userIDs).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                self.users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
                self.usernamesForTableView = self.users.map { $0.name }
                self.userTableView.tableViewSearchUserResults.reloadData()
            }
        }
    }
}

extension UserTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            usernamesForTableView = users.map { $0.name }
        } else {
            usernamesForTableView = users.filter { user in
                user.name.lowercased().contains(searchText.lowercased())
            }.map { $0.name }
        }
        self.userTableView.tableViewSearchUserResults.reloadData()
    }
}

