//
//  Chat.swift
//  Messenger App
//
//  Created by Jack Huang on 11/4/24.
//

import Foundation
import FirebaseFirestore

struct Chat: Codable {
    @DocumentID var id: String?
    var participantNames: [String]
    var participants: [String]
    var lastMessage: String?
    var lastMessageTime: Date?
    var messages: [Message]?
    
    init(participantNames: [String], participants: [String], lastMessage: String? = nil, lastMessageTime: Date? = nil, messages: [Message]? = nil) {
        self.participantNames = participantNames
        self.participants = participants
        self.lastMessage = lastMessage
        self.lastMessageTime = lastMessageTime
        self.messages = messages
    }
}
