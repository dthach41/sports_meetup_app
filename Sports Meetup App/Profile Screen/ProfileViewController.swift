//
//  ProfileViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/6/24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileView()
    
    let defaults = UserDefaults.standard
    
    
    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutBarButton = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(onClickLogoutBarItem))
        
        self.navigationItem.leftBarButtonItem = logoutBarButton
    }
    
    @objc func onClickLogoutBarItem() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    self.defaults.setValue(nil, forKey: "userID")
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }

}
