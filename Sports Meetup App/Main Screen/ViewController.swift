//
//  ViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 10/23/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    let database = Firestore.firestore()
        
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil {
                self.currentUser = nil
                
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)
            } else{
                self.currentUser = user
                
                //MARK: setting up chat tab bar...
                let tabChat = UINavigationController(rootViewController: ChatListViewController())
                let tabChatBarItem = UITabBarItem(
                    title: "Chat",
                    image: UIImage(systemName: "bubble.circle")?.withRenderingMode(.alwaysOriginal),
                    selectedImage: UIImage(systemName: "bubble.circle.fill")
                )
                tabChat.tabBarItem = tabChatBarItem
                
                //MARK: setting up home screen tab bar...
                let tabHome = UINavigationController(rootViewController: {
                    let mainScreenViewController = MainScreenViewController()
                    mainScreenViewController.currentUser = self.currentUser
                    return mainScreenViewController
                }())
                let tabHomeBarItem = UITabBarItem(
                    title: "Home",
                    image: UIImage(systemName: "house.circle"),
                    selectedImage: UIImage(systemName: "house.circle.fill")
                )
                tabHome.tabBarItem = tabHomeBarItem
                tabHome.toolbar.tintColor = .gray
                
                //MARK: setting up profile tab bar...
                let tabProfile = UINavigationController(rootViewController: {
                    let profileViewController = ProfileViewController()
                    profileViewController.currentUser = self.currentUser
                    profileViewController.userUID = self.currentUser?.uid
                    return profileViewController
                }())
                let tabProfileBarItem = UITabBarItem(
                    title: "Profile",
                    image: UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal),
                    selectedImage: UIImage(systemName: "person.circle.fill")
                )
                tabProfile.tabBarItem = tabProfileBarItem
                
                // Set the color for unselected tab items to gray
                self.tabBar.unselectedItemTintColor = .gray
                self.viewControllers = [tabChat, tabHome, tabProfile]
                // app opens up on tabHome
                self.selectedIndex = 1
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


