//
//  Event.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/19/24.
//

import Foundation
import FirebaseFirestore

struct Event: Codable {
    @DocumentID var id: String?
    var eventName: String
    var details: String
    var sport: String
    var hostID: String
    var participants: [String]
    var creationDate: Date
    var eventDate: Date
    var address: String
    
    // Default initializer
    init() {
        self.id = nil
        self.eventName = ""
        self.details = ""
        self.sport = ""
        self.hostID = ""
        self.participants = []
        self.creationDate = Date()
        self.eventDate = Date()
        self.address = ""
    }
    
    init (eventName: String, details: String, sport: String, hostID: String, participants: [String], creationDate: Date, eventDate: Date, address: String) {
        self.eventName = eventName
        self.details = details
        self.sport = sport
        self.hostID = hostID
        self.participants = [hostID]
        self.creationDate = creationDate
        self.eventDate = eventDate
        self.address = address
    }
    
}
