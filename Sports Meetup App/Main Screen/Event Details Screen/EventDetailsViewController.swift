//
//  EventDetailsViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/23/24.
//

import UIKit

import FirebaseFirestore

class EventDetailsViewController: UIViewController {
    
    let eventDetailsScreen = EventDetailsView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    let notificationCenter = NotificationCenter.default
    
    let defaults = UserDefaults.standard
    
    var event: Event!
    
    var joined: Bool!
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = eventDetailsScreen
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            self.event = await getEventByID(eventID: event.id!)
        }
        
        
        if (event.hostID == defaults.object(forKey: "userID") as! String) {
            joined = true
            let deleteButton = UIBarButtonItem(
                title: "Delete",
                style: .plain,
                target: self,
                action: #selector(onClickDelete))
            deleteButton.tintColor = .red
            
            self.navigationItem.rightBarButtonItem = deleteButton
            
            eventDetailsScreen.buttonEndEvent.isHidden = false
        }
        
        
        if (event.participants.contains(defaults.object(forKey: "userID") as! String)) {
            self.joined = true
        } else {
            self.joined = false
        }
        
        eventDetailsScreen.buttonJoin.addTarget(self, action: #selector(onClickButtonJoin), for: .touchUpInside)
        
        eventDetailsScreen.buttonEndEvent.addTarget(self, action: #selector(onClickButtonEndEvent), for: .touchUpInside)
        
        setupDetailsView()
    }
    
    
    // gets a event document by eventID and returns Event
    func getEventByID(eventID: String) async -> Event {
        let docRef = database.collection("events").document(event.id!)
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                let event = try document.data(as: Event.self)
                print(event)
                return event
            } else {
                print("Document does not exist")
            }
        } catch {
          print("Error getting documents: \(error)")
        }
        
        return Event()
    }
    
    
    func showConfirmDeleteAlert() {
        let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want to delete this event?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            Task {
                self.showActivityIndicator()
                await self.deleteEventFromFirestore()
            }
            
        })
        alert.addAction(deleteAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    // when delete button clicked
    @objc func onClickDelete() {
        showConfirmDeleteAlert()
    }
    
    
    func showConfirmEventFinished() {
        let alert = UIAlertController(title: "Confirm Event Finished", message: "This event will be deleted, and you will be awarded your EXP", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            Task {
                self.showActivityIndicator()
                self.updateEventFinishedForUsers()
                await self.deleteEventFromFirestore()
                
                
            }
            
        })
        alert.addAction(deleteAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    

    // updates the exp points, level and eventsFinished for all users who participated
    func updateEventFinishedForUsers() {
        for participantId in event.participants {
            Task {
                updateUserAfterEventFinished(userID: participantId)
            }
        }
    }
    
    // update given user's fields accounting for finished event
    func updateUserAfterEventFinished(userID: String) {
        Task {
            var thisUser = await getUserByID(userID: userID)
            
            let docRef = database.collection("users").document(thisUser.id!)
            
            thisUser.eventsFinished.append(event.id!)
            
            var updatedExp = thisUser.exp
            var updatedUserLevel = thisUser.level

            if updatedExp + 20 < 50 {
                // Increment experience without leveling up
                updatedExp += 20
            } else {
                // Handle leveling up
                let overflowExp = (updatedExp + 20) - 50 // Calculate leftover exp after leveling up
                updatedExp = overflowExp                // Set exp to leftover
                updatedUserLevel += 1                   // Increase level
            }
            
            // Field to update
            docRef.updateData([
                "eventsFinished": thisUser.eventsFinished,
                "level" : updatedUserLevel,
                "exp" : updatedExp
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    
                }
            }
        }
    }
    
    // when delete button clicked
    @objc func onClickButtonEndEvent() {
        showConfirmEventFinished()
    }
    
    
    // deletes event from Firestore
    func deleteEventFromFirestore() async {
        do {
            try await database.collection("events").document(event.id!).delete()
            self.notificationCenter.post(
                name: .updateMainScreen,
                object: nil)
            
            self.hideActivityIndicator()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Error removing document: \(error)")
        }
    }
    
    
    
    
    // remove this user from event's participant list
    @objc func onClickButtonJoin() {
        
        // if this user is the host, they can't leave,
        if (event.hostID == defaults.object(forKey: "userID") as! String) {
            
        }
        showActivityIndicator()
        // if this user already joined event
        if (self.joined) {
            removeThisUserFromEvent()
        }
        else {
            addThisUserToEvent()
        }
        
        self.joined = !self.joined!
        setupDetailsView()
    }
    
    
    
    func removeThisUserFromEvent() {
        let docRef = database.collection("events").document(event.id!)
        
        if let index = event.participants.firstIndex(of: defaults.object(forKey: "userID") as! String) {
            self.event.participants.remove(at: index)
        }

        // Field to update
        docRef.updateData([
            "participants": self.event.participants
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                
            }
        }
        
        self.notificationCenter.post(
            name: .updateMainScreen,
            object: nil)
        
        hideActivityIndicator()
    }
    

    
    func addThisUserToEvent() {
        let docRef = database.collection("events").document(event.id!)
        
        self.event.participants.append(defaults.object(forKey: "userID") as! String)

        // Field to update
        docRef.updateData([
            "participants": self.event.participants
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                
            }
        }
        
        self.notificationCenter.post(
            name: .updateMainScreen,
            object: nil)
        
        hideActivityIndicator()
    }
    
    // gets a user document by userID and returns User
    func getUserByID(userID: String) async -> User {
        let docRef = database.collection("users").document(userID)
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                let user = try document.data(as: User.self)
                return user
            } else {
                print("Document does not exist")
            }
        } catch {
          print("Error getting documents: \(error)")
        }
        
        return User()
    }
    

    func setupDetailsView() {
        Task{
            self.event = await getEventByID(eventID: event.id!)
        }
        
        eventDetailsScreen.labelEventName.text = event.eventName
        
        Task {
            let thisUser = await getUserByID(userID: defaults.object(forKey: "userID") as! String)
            eventDetailsScreen.labelHost.text = "Host: \(thisUser.name)"
        }
        
        eventDetailsScreen.labelAddress.text = event.address
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm" // Desired format
        let eventDate = event.eventDate
        eventDetailsScreen.labelEventDate.text = formatter.string(from: eventDate)
        eventDetailsScreen.labelParticipantsCount.text = String(event.participants.count)
        
        eventDetailsScreen.labelDetails.text = event.details
        
        let sportType = event.sport.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var image: UIImage!
        if sportType == "Basketball" {
            image = UIImage(systemName: "basketball.fill")
            eventDetailsScreen.imageIcon.tintColor = .orange
        }
        if sportType == "Soccer" {
            image = UIImage(systemName: "soccerball")
            eventDetailsScreen.imageIcon.tintColor = .black
        }
        if sportType == "Tennis" {
            image = UIImage(systemName: "tennisball.fill")
            eventDetailsScreen.imageIcon.tintColor = .yellow
        }
        if sportType == "Football" {
            image = UIImage(systemName: "figure.american.football")
            eventDetailsScreen.imageIcon.tintColor = .brown
        }
        
        eventDetailsScreen.imageIcon.image = image

        
        if (joined) {
            eventDetailsScreen.buttonJoin.setTitle("Joined", for: .normal)
            eventDetailsScreen.buttonJoin.setTitleColor(.black, for: .normal)
            eventDetailsScreen.buttonJoin.backgroundColor = .green
        } else {
            eventDetailsScreen.buttonJoin.setTitle("Join", for: .normal)
            eventDetailsScreen.buttonJoin.setTitleColor(.white, for: .normal)
            eventDetailsScreen.buttonJoin.backgroundColor = .gray
        }
        
    }

}


extension EventDetailsViewController:ProgressSpinnerDelegate{
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
