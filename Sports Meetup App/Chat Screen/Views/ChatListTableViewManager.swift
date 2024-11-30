//
//  ChatListTableViewManager.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 11/29/24.
//

import Foundation
import UIKit

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatTableViewCell
        
        let chat = chatRooms[indexPath.row]
        var receivers = ""
        for name in chat.participantNames {
            if name != currentUser?.displayName {
                // add commas between users for group chats
                receivers.append(name)
            }
        }
        cell.labelReceiverName.text = receivers

        if let lastMessage = chat.lastMessage {
            cell.labelLastMessage.text = lastMessage
            cell.labelLastMessage.numberOfLines = 1
            cell.labelLastMessage.lineBreakMode = .byTruncatingTail
        } else {
            cell.labelLastMessage.text = ""
        }
        
        if let lastMessageTime = chat.lastMessageTime {
            cell.labelLastMessageTime.text = DateFormatter.localizedString(from: lastMessageTime, dateStyle: .short, timeStyle: .short)
        } else {
            cell.labelLastMessageTime.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewController = ChatViewController()
        chatViewController.currentUser = currentUser
        
        let chat = chatRooms[indexPath.row]
        for uid in chat.participants {
            if uid != currentUser?.uid {
                database.collection("users").document(uid).getDocument { (document, error) in
                    if error == nil {
                        if let document = document, document.exists {
                            do {
                                let user = try document.data(as: User.self)
                                chatViewController.otherUser = user
                                
                                self.navigationController?.pushViewController(chatViewController, animated: true)
                            } catch {
                                print("Error decoding user data")
                            }
                        } else {
                            print("User does not exist")
                        }
                    } else {
                        print(error)
                    }
                }

            }
        }
    }
}
