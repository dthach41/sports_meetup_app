//
//  MainScreenViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/6/24.
//

import FirebaseFirestore

import UIKit

class MainScreenViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    let database = Firestore.firestore()
    
    let notificationCenter = NotificationCenter.default
    
    // list of all events
    var events = [Event]()
    
    override func loadView() {
        view = mainScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: observing for when to update mainscreen if it is updated in NotificationCenter...
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedUpdateMainScreen(notification:)),
            name: .updateMainScreen,
            object: nil)
        
        mainScreen.tableViewEvents.delegate = self
        mainScreen.tableViewEvents.dataSource = self
        mainScreen.tableViewEvents.separatorStyle = .none

        Task {
            await getAllEventsFromFirestore()
        }

        // Do any additional setup after loading the view.
        let newEventButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.rectangle"),
            style: .plain,
            target: self,
            action: #selector(onClickNewEvent))
        
        self.navigationItem.rightBarButtonItem = newEventButton
        
    }
    
    // updates events tableview for new event
    @objc func notificationReceivedUpdateMainScreen(notification: Notification) {
        Task {
            await self.getAllEventsFromFirestore()
        }
    }
    
    // when top right nav bar button clicked go to new event screen
    @objc func onClickNewEvent() {
        let newEventViewController = NewEventViewController()
        navigationController?.pushViewController(newEventViewController, animated: true)
    }
    
    
    // gets all events from Firestore and update events list and view
    func getAllEventsFromFirestore() async {
        events.removeAll()
        do {
            let querySnapshot = try await self.database.collection("events").getDocuments()
            for document in querySnapshot.documents {
                do {
                    let event = try document.data(as: Event.self)
                    self.events.append(event)
                } catch {
                    print(error)
                }
            }

        } catch {
          print("Error getting documents: \(error)")
        }
        
        mainScreen.tableViewEvents.reloadData()
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

}


extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "events", for: indexPath) as! TableViewEventCell
        
        Task {
            let user = await self.getUserByID(userID: events[indexPath.row].hostID)
            cell.labelHost.text = "Host: \(user.name)"
            
        }
        
        cell.labelEventName.text = events[indexPath.row].eventName
        cell.labelAddress.text = events[indexPath.row].address
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm" // Desired format
        let eventDate = events[indexPath.row].eventDate
        cell.labelEventDate.text = formatter.string(from: eventDate)
        cell.labelParticipantsCount.text = String(events[indexPath.row].participants.count)
        
        let sportType = events[indexPath.row].sport.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var image: UIImage!
        if sportType == "Basketball" {
            image = UIImage(systemName: "basketball.fill")
            cell.imageIcon.tintColor = .orange
        }
        if sportType == "Soccer" {
            image = UIImage(systemName: "soccerball")
            cell.imageIcon.tintColor = .black
        }
        if sportType == "Tennis" {
            image = UIImage(systemName: "tennisball.fill")
            cell.imageIcon.tintColor = .yellow
        }
        if sportType == "Football" {
            image = UIImage(systemName: "figure.american.football")
            cell.imageIcon.tintColor = .brown
        }
        
        
        cell.imageIcon.image = image
        
        return cell
    }
    
    // handle on click of cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let event = events[indexPath.row]
        
        let eventDetailsController = EventDetailsViewController()
        eventDetailsController.event = event
        
        // unhighlights cell after clicking
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(eventDetailsController, animated: true)
        
        
    }
    
}
