//
//  Message.swift
//  Messenger App
//
//  Created by Jack Huang on 11/4/24.
//

import Foundation
import FirebaseFirestore

struct Message: Codable {
    @DocumentID var id: String?
    var uid: String
    var name: String
    var text: String
    var sentAt: Date
    
    init(uid: String, name: String, text: String, sentAt: Date = Date()) {
        self.uid = uid
        self.name = name
        self.text = text
        self.sentAt = sentAt
    }
}
