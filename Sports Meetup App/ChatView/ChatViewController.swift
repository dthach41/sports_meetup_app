//
//  ChatViewController.swift
//  Messenger App
//
//  Created by Jack Huang on 11/4/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    let chatView = ChatView()
    let database = Firestore.firestore()
    let childProgressView = ProgressSpinnerViewController()
    
    var messages = [Message]()
    var currentUser: FirebaseAuth.User!
    var otherUser: User!
    
    override func loadView() {
        view = chatView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = otherUser.displayName

        chatView.buttonSend.addTarget(self, action: #selector(onButtonSendTapped), for: .touchUpInside)
        
        chatView.tableViewMessages.delegate = self
        chatView.tableViewMessages.dataSource = self
        
        chatView.tableViewMessages.separatorStyle = .none
        
        hideKeyboardOnTapOutside()
    }
    
    @objc func onButtonSendTapped() {
        showActivityIndicator()
        if let messageText = chatView.textfieldMessage.text, messageText != "" {
            chatView.textfieldMessage.text = ""
            let message = Message(uid: currentUser.uid, name: currentUser.displayName!, text: messageText)
            addMessageToFirestore(message: message)
        } else {
            showErrorAlert(errorText: "Cannot send empty message!")
        }
    }
    
    func loadMessages() {
        let currentUserID = currentUser.uid
        if let otherUserID = otherUser.uid {
            database.collection("chats")
                .document(getChatIDForUsers(userIds: [currentUserID, otherUserID]))
                .collection("messages")
                .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                    if let documents = querySnapshot?.documents {
                        self.messages.removeAll()
                        for document in documents {
                            do {
                                let message = try document.data(as: Message.self)
                                self.messages.append(message)
                            } catch {
                                print(error)
                            }
                        }
                        self.messages.sort(by: {$0.sentAt < $1.sentAt})
                        self.chatView.tableViewMessages.reloadData()
                        self.scrollToBottom()
                    }
                })
        }
    }
    
    func addMessageToFirestore(message: Message) {
        let currentUserID = currentUser.uid
        if let otherUserID = otherUser.uid {
            let collectionMessages = database
                .collection("chats")
                .document(getChatIDForUsers(userIds: [currentUserID, otherUserID]))
                .collection("messages")
            
            do {
                try collectionMessages.addDocument(from: message, completion: {(error) in
                    if error == nil {
                        self.hideActivityIndicator()
                        self.loadMessages()
                        self.updateLastMessageDetails(message: message)
                    }
                })
            } catch {
                print("Error adding message to chat")
            }
        }
    }
    
    func updateLastMessageDetails(message: Message) {
        let lastMessageData: [String: Any] = [
            "lastMessage": message.text,
            "lastMessageTime": message.sentAt
        ]
        
        let currentUserID = currentUser.uid
        if let otherUserID = otherUser.uid {
            database.collection("chats")
                .document(getChatIDForUsers(userIds: [currentUserID, otherUserID]))
                .updateData(lastMessageData) { error in
                    if let error = error {
                        print("Error updating chat document: \(error)")
                    } else {
                        print("Chat document updating successfully with last message: \(message.text)")
                    }
                }
        }
    }
    
    func getChatIDForUsers(userIds: [String]) -> String {
        return userIds.sorted().joined(separator: "_")
    }
    
    func scrollToBottom() {
        if messages.isEmpty {
            return
        }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        chatView.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func hideKeyboardOnTapOutside() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    func showErrorAlert(errorText:String) {
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
