//
//  User.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/24/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
    @DocumentID var id: String?
    var email: String
    var profilePic: String
    var phone: String
    var name: String
    var bio: String 
    var followers: [String]
    var following: [String]
    var level: Int
    var exp: Int
    var eventsFinished: [String]
    
    // Default initializer
    init() {
        self.id = nil
        self.email = ""
        self.profilePic = ""
        self.phone = ""
        self.name = ""
        self.bio = ""
        self.followers = []
        self.following = []
        self.level = 0
        self.exp = 0
        self.eventsFinished = []
    }
    
    // Custom initializer
    init(email: String, profilePic: String, phone: String, name: String) {
        self.email = email
        self.profilePic = profilePic
        self.phone = phone
        self.name = name
        self.bio = ""
        self.followers = []
        self.following = []
        self.level = 1
        self.exp = 0
        self.eventsFinished = []
    }
}

