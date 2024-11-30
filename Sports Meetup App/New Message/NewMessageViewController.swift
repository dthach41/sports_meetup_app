//
//  NewMessageViewController.swift
//  Messenger App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class NewMessageViewController: UIViewController {

    let newMessageScreen = NewMessageView()
    let database = Firestore.firestore()
    let childProgressView = ProgressSpinnerViewController()
    
    var users = [User]()
    var userEmailsForTableView = [String]()
    var currentUser: FirebaseAuth.User!
    var otherUser: User!
    
    override func viewWillAppear(_ animated: Bool) {
        self.database.collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching users: \(error)")
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    self.users.removeAll()
                    for document in documents {
                        do {
                            let user = try document.data(as: User.self)
                            if user.uid != self.currentUser.uid {
                                self.users.append(user)
                                self.userEmailsForTableView.append(user.email)
                            }
                        } catch {
                            print("Error decoding user data")
                        }
                        self.newMessageScreen.tableViewSearchResults.reloadData()
                    }
                } else {
                    print("No users found.")
                    return
                }
            }
    }
    
    override func loadView() {
        view = newMessageScreen
        
        hideKeyboardOnTapOutside()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // newMessageScreen.buttonSend.addTarget(self, action: #selector(onClickButtonSend), for: .touchUpInside)
        
        newMessageScreen.tableViewSearchResults.delegate = self
        newMessageScreen.tableViewSearchResults.dataSource = self
        
        newMessageScreen.searchBar.delegate = self
    }
    
    func showErrorAlert(errorText: String) {
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // adds a new chat document to chats collection
    func addChatToFirestore() {
        let chatData = [
            "participantNames": [currentUser.displayName, otherUser.displayName],
            "participants": [self.currentUser.uid, otherUser.uid],
            "lastMessage": nil,
            "lastMessageTime": nil
        ]
        if let otherUID = otherUser.uid {
            let chatID = getChatIDForUsers(userIds: [self.currentUser.uid, otherUID]);
            
            database.collection("chats")
                .document(chatID).setData(chatData) { error in
                    if let error = error {
                        print("Error creating chat document: \(error)")
                    } else {
                        self.hideActivityIndicator()
                        print("Chat document created successfully with ID: \(chatID)")
                    }
                }
        }
    }
    
    func getChatIDForUsers(userIds: [String]) -> String {
        return userIds.sorted().joined(separator: "_")
    }
    
    func hideKeyboardOnTapOutside() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}

extension NewMessageViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            userEmailsForTableView = users.map { $0.email }
        } else {
            userEmailsForTableView = users.filter { user in
                user.email.lowercased().contains(searchText.lowercased())
            }.map { $0.email }
        }
        self.newMessageScreen.tableViewSearchResults.reloadData()
    }
}

extension NewMessageViewController: ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
