//
//  EventParticipantsViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 12/5/24.
//

import UIKit
import FirebaseFirestore

class EventParticipantsViewController: UIViewController {
    
    let eventParticipantsScreen = EventParticipantsView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    
    var participant_IDs = [String]()
    var participants = [User]()
    
    
    override func loadView() {
        view = eventParticipantsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Participants"
        
        Task {
            showActivityIndicator()
            await getParticipantsFromFirestore()
            hideActivityIndicator()
        }
        
        eventParticipantsScreen.tableViewParticipants.delegate = self
        eventParticipantsScreen.tableViewParticipants.dataSource = self
        eventParticipantsScreen.tableViewParticipants.separatorStyle = .none
    }
    
    // get all participants in self.participant_IDs from Firestore
    func getParticipantsFromFirestore() async {
        participants.removeAll()
        do {
            let querySnapshot = try await self.database.collection("users").getDocuments()
            for document in querySnapshot.documents {
                do {
                    let user = try document.data(as: User.self)
                    if participant_IDs.contains(user.id!) {
                        self.participants.append(user)
                    }
                    
                } catch {
                    print(error)
                }
            }
        } catch {
          print("Error getting documents: \(error)")
        }
        
        
        eventParticipantsScreen.tableViewParticipants.reloadData()
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


extension EventParticipantsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participants", for: indexPath) as! ParticipantTableViewCell
        
        Task {
            let user = await self.getUserByID(userID: participants[indexPath.row].id!)
            cell.labelName.text = "\(user.name)"
        
            
        }
    
        return cell
    }
    
    // handle on click of cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let clickedUserID = participants[indexPath.row]

        // unhighlights cell after clicking
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


extension EventParticipantsViewController:ProgressSpinnerDelegate{
    func showActivityIndicator() {
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
