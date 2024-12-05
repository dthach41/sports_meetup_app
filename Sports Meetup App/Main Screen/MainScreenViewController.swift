//
//  MainScreenViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/6/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MainScreenViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    let notificationCenter = NotificationCenter.default
    
    var currentUser: FirebaseAuth.User!
    // list of all events
    var eventsDatabase = [Event]()
    
    //MARK: the list of events displayed when searching
    var eventsForTableView = [Event]()
    
    // different options for selecting in sports filter menu
    let sports = ["None", "Basketball", "Football", "Soccer", "Tennis"]
    var selectedSport = "None"
    
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
        
        mainScreen.searchBar.delegate = self
        
        mainScreen.tableViewEvents.delegate = self
        mainScreen.tableViewEvents.dataSource = self
        mainScreen.tableViewEvents.separatorStyle = .none

        Task {
            showActivityIndicator()
            await getAllEventsFromFirestore()
            hideActivityIndicator()
        }

        // Do any additional setup after loading the view.
        let newEventButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.rectangle"),
            style: .plain,
            target: self,
            action: #selector(onClickNewEvent))
        
        self.navigationItem.rightBarButtonItem = newEventButton
        
        mainScreen.buttonFilterTableView.menu = getSportTypes()

        
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
        eventsDatabase.removeAll()
        do {
            let querySnapshot = try await self.database.collection("events").getDocuments()
            for document in querySnapshot.documents {
                do {
                    let event = try document.data(as: Event.self)
                    self.eventsDatabase.append(event)
                } catch {
                    print(error)
                }
            }
            self.eventsForTableView = eventsDatabase
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

    func getSportTypes() -> UIMenu {
        var menuItems = [UIAction]()

        for type in sports {
            let menuItem = UIAction(
                title: type,
                state: self.selectedSport == type ? .on : .off, // Highlight the selected item
                handler: { _ in
                    self.selectedSport = type
                    self.mainScreen.buttonFilterTableView.menu = self.getSportTypes()
                    self.updateFilteredEventsForTableView(sport: self.selectedSport)
                }
            )
            menuItems.append(menuItem)
        }

        return UIMenu(title: "Filter by sport:", children: menuItems)
    }
    

    
    func updateFilteredEventsForTableView(sport: String) {
        switch sport {
        case "Basketball":
            self.eventsForTableView = self.eventsDatabase.filter { $0.sport == "Basketball" }
        case "Soccer":
            self.eventsForTableView = self.eventsDatabase.filter { $0.sport == "Soccer" }
        case "Football":
            self.eventsForTableView = self.eventsDatabase.filter { $0.sport == "Football" }
        case "Tennis":
            self.eventsForTableView = self.eventsDatabase.filter { $0.sport == "Tennis" }
        case "None":
            self.eventsForTableView = self.eventsDatabase
        default:
            self.eventsForTableView = self.eventsDatabase // Default to showing all items
        }
        
        
        // Reload your UI component (e.g., a UITableView or UICollectionView)
        self.mainScreen.tableViewEvents.reloadData()
    }
    

}


//MARK: adopting the search bar protocol...
extension MainScreenViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            eventsForTableView = eventsDatabase
        }else {
            self.eventsForTableView.removeAll()

            for event in eventsDatabase{
                if event.eventName.lowercased().contains(searchText.lowercased()) || event.address.lowercased().contains(searchText.lowercased()) || event.sport.lowercased().contains(searchText.lowercased()) {
                    self.eventsForTableView.append(event)
                }
            }
        }
        self.mainScreen.tableViewEvents.reloadData()
    }
}


extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "events", for: indexPath) as! TableViewEventCell
        
        Task {
            let user = await self.getUserByID(userID: eventsForTableView[indexPath.row].hostID)
            cell.labelHost.text = "Host: \(user.name)"
            
        }
        
        cell.labelEventName.text = eventsForTableView[indexPath.row].eventName
        cell.labelAddress.text = eventsForTableView[indexPath.row].address
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm" // Desired format
        let eventDate = eventsForTableView[indexPath.row].eventDate
        cell.labelEventDate.text = formatter.string(from: eventDate)
        cell.labelParticipantsCount.text = String(eventsForTableView[indexPath.row].participants.count)
        
        let sportType = eventsForTableView[indexPath.row].sport.trimmingCharacters(in: .whitespacesAndNewlines)
        
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
        
        let event = eventsForTableView[indexPath.row]
        
        let eventDetailsController = EventDetailsViewController()
        eventDetailsController.currentUser = currentUser
        eventDetailsController.event = event
        
        // unhighlights cell after clicking
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(eventDetailsController, animated: true)
        
    }
    
}

extension MainScreenViewController:ProgressSpinnerDelegate{
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
