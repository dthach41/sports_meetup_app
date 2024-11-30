//
//  ChatTableViewManager.swift
//  Messenger App
//
//  Created by Jack Huang on 11/4/24.
//

import Foundation
import UIKit

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        var cell: UITableViewCell
        if message.uid == currentUser.uid {
            cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewSenderID, for: indexPath) as! SenderTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewReceiverID, for: indexPath) as! ReceiverTableViewCell
        }
        
        cell.selectionStyle = .none
        
        if let senderCell = cell as? SenderTableViewCell {
            senderCell.labelName.text = message.name
            senderCell.labelText.text = message.text
            senderCell.labelDateTime.text = DateFormatter.localizedString(from: message.sentAt, dateStyle: .short, timeStyle: .short)
        } else if let receiverCell = cell as? ReceiverTableViewCell {
            receiverCell.labelName.text = message.name
            receiverCell.labelText.text = message.text
            receiverCell.labelDateTime.text = DateFormatter.localizedString(from: message.sentAt, dateStyle: .short, timeStyle: .short)
        }
        
        return cell
    }
}
