//
//  RegisterViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI
import FirebaseStorage


class RegisterViewController: UIViewController {
    let registerScreen = RegisterView()

    let database = Firestore.firestore()
    
    let storage = Storage.storage()
    
    let childProgressView = ProgressSpinnerViewController()
    
    // variable to store the picked image
    var pickedImage: UIImage?
    
    override func loadView() {
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickedImage = UIImage(systemName: "person.crop.circle.fill")

        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterClicked), for: .touchUpInside)
        
        registerScreen.buttonSelectPicture.menu = getPictureTypes()
    }
    
    
    // menu for buttonSelectPicture
    func getPictureTypes() -> UIMenu {
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    func showEmptyFields() {
        let alert = UIAlertController(title: "Error!", message: "Please fill out all the fields", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showInvalidEmail() {
        let alert = UIAlertController(title: "Error!", message: "Invalid email", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showInvalidPhoneNumber() {
        let alert = UIAlertController(title: "Error!", message: "Invalid Phone Number", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showUserAlreadyExists() {
        let alert = UIAlertController(title: "", message: "User already exists", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showPasswordNotMatching() {
        let alert = UIAlertController(title: "", message: "Passwords do not match. Please try again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showAccountAlreadyExists() {
        let alert = UIAlertController(title: "", message: "Account already exists! Please enter a different email", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showPasswordLengthError() {
        let alert = UIAlertController(title: "", message: "Password must be 6 characters or longer", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
    func uploadProfilePhotoToStorage() {
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage {
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.registerNewAccount(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }
    }
    
    
    // registers on Firebase
    func registerNewAccount(photoURL: URL?){
        if let name = registerScreen.textFieldName.text,
           let email = registerScreen.textFieldEmail.text,
           let password = registerScreen.textFieldPassword.text {
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil {
                    self.setNameAndPhotoOfTheUserInFirebaseAuth(name: name, photoURL: photoURL)
                    if let newUser = Auth.auth().currentUser {
                        self.createUserDoc(user: newUser, photoURL: photoURL!)
                    }
                    
                    self.hideActivityIndicator()
                } else {
                    print("Account Already Exist")
                    self.hideActivityIndicator()
                    self.showAccountAlreadyExists()
                    
                }
            })
        }
    }
    
    
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    func createUserDoc(user: FirebaseAuth.User, photoURL: URL) {
        let userData = [
            "email": user.email ?? "",
            "profilePic" : photoURL.absoluteString,
            "phone": registerScreen.textFieldPhoneNumber.text ?? "",
            "name": registerScreen.textFieldName.text!,
            "bio": "",
            "followers": [],
            "following" : [],
            "level": 1,
            "exp": 0,
            "eventsFinished": []
        ] as [String : Any]
        database.collection("users").document(user.uid).setData(userData) { error in
            if let error = error {
                print("Error creating user document: \(error)")
            } else {
                print("User document created successfully with ID: \(user.uid)")
            }
        }
    }
    
    @objc func onButtonRegisterClicked() {
        if registerScreen.textFieldName.text! == "" || registerScreen.textFieldPassword.text! == "" {
            showEmptyFields()
        }
        else if !isValidEmail(email: registerScreen.textFieldEmail.text!) {
            showInvalidEmail()
        }
        else if registerScreen.textFieldPhoneNumber.text!.count < 10 {
            showInvalidPhoneNumber()
        }
        else if registerScreen.textFieldPassword.text! != registerScreen.textfieldConfirmPassword.text! {
            showPasswordNotMatching()
        }
        else if registerScreen.textFieldPassword.text!.count < 6 {
            showPasswordLengthError()
        }
        else {
            showActivityIndicator()
            uploadProfilePhotoToStorage()
        }
    }
}

extension RegisterViewController:ProgressSpinnerDelegate{
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

//MARK: adopting required protocols for PHPicker...
extension RegisterViewController:PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)

        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.registerScreen.buttonSelectPicture.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.registerScreen.buttonSelectPicture.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else {
            // Do your thing for No image loaded...
        }
    }
}

