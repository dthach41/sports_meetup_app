//
//  ProfileEditViewController.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileEditViewController: UIViewController {
    
    let profileEditView = ProfileEditView()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let childProgressView = ProgressSpinnerViewController()
    
    var imagePickerManager: ImagePickerManager!
    var userProfile: User!
    
    override func loadView() {
        view = profileEditView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setProfileFields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerManager = ImagePickerManager(viewController: self)
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        profileEditView.imageProfilePic.addGestureRecognizer(imageTapGesture)
        
        profileEditView.saveButton.addTarget(self, action: #selector(saveProfileChanges), for: .touchUpInside)
    }
    
    @objc func selectPhoto() {
        imagePickerManager.presentImagePicker { [weak self] image in
            self?.profileEditView.imageProfilePic.image = image?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    @objc func saveProfileChanges() {
        guard let updatedName = profileEditView.textFieldName.text,
              let updatedBio = profileEditView.textFieldBio.text else {
            print("Invalid input")
            return
        }
        showActivityIndicator()
        
        deleteOldProfilePhoto(photoURL: Auth.auth().currentUser?.photoURL)
        uploadProfilePhotoToStorage { [weak self] photoURL in
            let photoURLString = photoURL?.absoluteString ?? ""
            self?.updateUserProfile(name: updatedName, bio: updatedBio, photoURL: photoURL)
            self?.updateFirestoreUser(name: updatedName, bio: updatedBio, photoURL: photoURLString)
        }
    }
    
    func setProfileFields() {
        if let url = URL(string: userProfile.profilePic) {
            profileEditView.imageProfilePic.loadRemoteImage(from: url)
        } else {
            profileEditView.imageProfilePic.image = UIImage(systemName: "person.circle.fill")
        }

        profileEditView.textFieldName.text = "\(userProfile.name)"
        profileEditView.textFieldBio.text = "\(userProfile.bio)"
    }
    
    func uploadProfilePhotoToStorage(completion: @escaping (URL?) -> Void) {
        guard let image = profileEditView.imageProfilePic.image,
              let jpegData = image.jpegData(compressionQuality: 80) else {
            completion(nil)
            return
        }
        
        let imageRef = storage.reference().child("profileImages/\(NSUUID().uuidString).jpg")
        
        imageRef.putData(jpegData) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error)")
                completion(nil)
            } else {
                imageRef.downloadURL { url, error in
                    if let url = url {
                        completion(url)
                    } else {
                        print("Error getting download URL: \(String(describing: error))")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func updateUserProfile(name: String, bio: String, photoURL: URL?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Error updating profile: \(error)")
            } else {
                print("Profile updated successfully")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func updateFirestoreUser(name: String, bio: String, photoURL: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
                
        db.collection("users").document(userId).updateData([
            "name": name,
            "bio": bio,
            "profilePic": photoURL
        ]) { [weak self] error in
            self?.hideActivityIndicator()
            if let error = error {
                print("Error updating Firestore profile: \(error.localizedDescription)")
            } else {
                print("Firestore profile updated successfully")
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func deleteOldProfilePhoto(photoURL: URL?) {
        guard let photoURL = photoURL else {
            print("No previous photo to delete.")
            return
        }
        
        let storageRef = storage.reference(forURL: photoURL.absoluteString)
        
        storageRef.delete { error in
            if let error = error {
                // Handle error gracefully
                if (error as NSError).code == StorageErrorCode.objectNotFound.rawValue {
                    print("No previous photo found in Storage, skip deletion.")
                } else {
                    print("Error deleting photo: \(error.localizedDescription)")
                }
            } else {
                print("Previous profile photo deleted successfully.")
            }
        }
    }
}

extension ProfileEditViewController:ProgressSpinnerDelegate{
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
