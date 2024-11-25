//
//  NewEventViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/19/24.
//

import UIKit

import FirebaseFirestore

class NewEventViewController: UIViewController {
    
    let newEventScreen = NewEventView()
    
    let defaults = UserDefaults.standard
    
    let database = Firestore.firestore()
    
    let notificationCenter = NotificationCenter.default
    
    let childProgressView = ProgressSpinnerViewController()
    
    // different options for selecting in sports menu
    let sports = ["Basketball", "Football", "Soccer", "Tennis"]
    var selectedSport = ""
    

    override func loadView() {
        view = newEventScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Event"
        
        newEventScreen.buttonSelectSportMenu.menu = getSportTypes()
        
        // Do any additional setup after loading the view.
        let buttonCreateEvent = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(onClickCreateEvent))
        
        self.navigationItem.rightBarButtonItem = buttonCreateEvent
    }
    
    func showEmptyField() {
        let alert = UIAlertController(title: "Empty Fields", message: "Required fields are still empty", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
    @objc func onClickCreateEvent() {
        let eventName = newEventScreen.textFieldEventName.text!
        let details = newEventScreen.textViewDetails.text!
        let sport = selectedSport
        let hostid = defaults.object(forKey: "userID") as! String
        let participants = [hostid]
        let creationDate = Date()
        let eventDate = newEventScreen.datePickerEventDate.date
        let address = newEventScreen.textFieldAddress.text!
        
        if eventName.isEmpty || sport.isEmpty || address.isEmpty || details.isEmpty {
            showEmptyField()
        } else {
            let newEvent = Event(eventName: eventName, details: details, sport: sport,
                                 hostID: hostid, participants: participants,
                                 creationDate: creationDate, eventDate: eventDate, address: address)
            
            showActivityIndicator()
            addEventToFirestore(event: newEvent)
        }
        
    }
    
    
    // adds a event document to events collection in Firestore database
    func addEventToFirestore(event: Event) {
        database.collection("events").document().setData([
          "eventName": event.eventName,
          "details": event.details,
          "sport": event.sport,
          "hostID": event.hostID,
          "participants": event.participants,
          "creationDate": event.creationDate,
          "eventDate": event.eventDate,
          "address": event.address]) {error in
              if let error = error {
                  print("Error creating event document: \(error)")
              } else {
                  self.notificationCenter.post(
                      name: .updateMainScreen,
                      object: nil)
                  self.hideActivityIndicator()
                  self.navigationController?.popViewController(animated: true)
                  print("Event document created successfully")
              }
          }
    }
    
    
    func getSportTypes() -> UIMenu {
        var menuItems = [UIAction]()
        
        for type in sports {
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedSport = type
                                self.newEventScreen.buttonSelectSportMenu.setTitle(self.selectedSport, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select Sport:", children: menuItems)
    }

}

extension NewEventViewController:ProgressSpinnerDelegate{
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

