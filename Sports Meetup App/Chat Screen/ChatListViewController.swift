//
//  ChatListViewController.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 11/29/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatListViewController: UIViewController {

    let chatListView = ChatListView()
        
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    let database = Firestore.firestore()
    var chatRooms = [Chat]()
    
    override func loadView() {
        view = chatListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                self.currentUser = nil
                
                self.chatRooms.removeAll()
                self.chatListView.tableViewChatRooms.reloadData()
                
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }else{
                self.currentUser = user
                
                self.chatListView.buttonNewMessage.addTarget(self, action: #selector(self.onNewMessageButtonClicked), for: .touchUpInside)

                self.database.collection("chats")
                    .whereField("participants", arrayContains: self.currentUser?.uid)
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.chatRooms.removeAll()
                            for document in documents{
                                do{
                                    let chat  = try document.data(as: Chat.self)
                                    self.chatRooms.append(chat)
                                }catch{
                                    print(error)
                                }
                            }
                            
                            print(self.chatRooms)
                            self.chatRooms.sort(by: {
                                if let firstDate = $0.lastMessageTime, let secondDate = $1.lastMessageTime {
                                    return firstDate > secondDate
                                } else if $0.lastMessageTime == nil {
                                    return false
                                } else {
                                    return true
                                }
                            })
                            self.chatListView.tableViewChatRooms.reloadData()
                        }
                    })
            }
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Message"
        
        chatListView.tableViewChatRooms.delegate = self
        chatListView.tableViewChatRooms.dataSource = self
    }
    
    @objc func onSignOutClicked() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    @objc func onNewMessageButtonClicked() {
        let newMessageViewController = NewMessageViewController()
        newMessageViewController.currentUser = self.currentUser
        navigationController?.pushViewController(newMessageViewController, animated: true)
    }
}
