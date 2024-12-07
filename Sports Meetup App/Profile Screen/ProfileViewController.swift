//
//  ProfileViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/6/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileView()
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    
    var currentUser = Auth.auth().currentUser
    var userUID: String!
    var userProfile: User!
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userUID == currentUser?.uid {
            let logoutBarButton = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                style: .plain,
                target: self,
                action: #selector(onClickLogoutBarItem))
            
            self.navigationItem.leftBarButtonItem = logoutBarButton
        }
        
        profileScreen.buttonEdit.addTarget(self, action: #selector(onButtonEditClicked), for: .touchUpInside)
        profileScreen.buttonFollow.addTarget(self, action: #selector(onButtonFollowClicked), for: .touchUpInside)
        
        let followersTapGesture = UITapGestureRecognizer(target: self, action: #selector(onFollowersLabelTapped))
        profileScreen.labelFollowers.addGestureRecognizer(followersTapGesture)

        let followingTapGesture = UITapGestureRecognizer(target: self, action: #selector(onFollowingLabelTapped))
        profileScreen.labelFollowing.addGestureRecognizer(followingTapGesture)
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
    
    @objc func onFollowersLabelTapped() {
        navigateToUserList(userIDs: userProfile.followers, title: "Followers")
    }

    @objc func onFollowingLabelTapped() {
        navigateToUserList(userIDs: userProfile.following, title: "Following")
    }
    
    @objc func onButtonEditClicked() {
        let profileEditViewController = ProfileEditViewController()
        profileEditViewController.userProfile = userProfile
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
    
    @objc func onButtonFollowClicked() {
        followUser()
    }
    
    func navigateToUserList(userIDs: [String], title: String) {
        let userTableViewController = UserTableViewController()
        userTableViewController.userIDs = userIDs
        userTableViewController.listTitle = title
        navigationController?.pushViewController(userTableViewController, animated: true)
    }
    
    func setProfileDetails() {
        if let url = URL(string: userProfile.profilePic) {
            profileScreen.imageProfilePic.loadRemoteImage(from: url)
        } else {
            profileScreen.imageProfilePic.image = UIImage(systemName: "person.circle.fill")
        }

        profileScreen.labelName.text = "\(userProfile.name)"
        profileScreen.labelEmail.text = "\(userProfile.email)"
        profileScreen.labelBio.text = "\(userProfile.bio)"
        profileScreen.labelLevel.text = "Level: \(userProfile.level)"
        profileScreen.labelFollowers.text = "Followers: \(userProfile.followers.count)"
        profileScreen.labelFollowing.text = "Following: \(userProfile.following.count)"
        
        if currentUser?.uid == userUID {
            profileScreen.showEditButton()
        } else {
            profileScreen.showFollowButton()
        }
    }
    
    func fetchUserProfile() {
        guard let profileUID = userUID else {
            print("No current user ID found.")
            return
        }
        
        db.collection("users").document(profileUID).getDocument { document, error in
            if let error = error {
                print("Error fetching user profile: \(error)")
                return
            }
            
            if let document = document, document.exists {
                do {
                    self.userProfile = try document.data(as: User.self)
                    self.setProfileDetails()
                    self.updateFollowButton()
                } catch {
                    print("Error decoding user data: \(error)")
                }
            } else {
                print("User profile does not exist.")
            }
        }
    }
    
    func followUser() {
        guard let currentUserID = currentUser?.uid, let profileUID = userUID else { return }
        
        let currentUserRef = db.collection("users").document(currentUserID)
        print(currentUserRef)
        let profileUserRef = db.collection("users").document(profileUID)
        print(profileUserRef)

        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let currentUserDoc: DocumentSnapshot
            let profileDoc: DocumentSnapshot
            
            do {
                currentUserDoc = try transaction.getDocument(currentUserRef)
                profileDoc = try transaction.getDocument(profileUserRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            var currentFollowing = currentUserDoc.data()?["following"] as? [String] ?? []
            var profileFollowers = profileDoc.data()?["followers"] as? [String] ?? []
            
            let isFollowing = currentFollowing.contains(profileUID)
            if isFollowing {
                currentFollowing.removeAll { $0 == profileUID }
                profileFollowers.removeAll { $0 == currentUserID }
            } else {
                currentFollowing.append(profileUID)
                profileFollowers.append(currentUserID)
            }
            
            transaction.updateData(["following": currentFollowing], forDocument: currentUserRef)
            transaction.updateData(["followers": profileFollowers], forDocument: profileUserRef)
            
            return isFollowing ? "unfollowed" : "followed"
        }) { (result, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
            } else if let action = result as? String {
                print("Successfully \(action) user.")
                self.updateFollowButton()
                self.fetchUserProfile()
            }
        }
    }
    
    func updateFollowButton() {
        guard let currentUserID = currentUser?.uid else { return }
        
        if userProfile.followers.contains(currentUserID) {
            profileScreen.buttonFollow.setTitle("Following", for: .normal)
        } else {
            profileScreen.buttonFollow.setTitle("Follow", for: .normal)
        }
    }
}
