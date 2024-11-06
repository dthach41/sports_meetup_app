//
//  RegisterViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegisterViewController: UIViewController {
    let registerScreen = RegisterView()

    let database = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterClicked), for: .touchUpInside)
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
    
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    // registers on Firebase
    func registerNewAccount(){
        showActivityIndicator()
        if let name = registerScreen.textFieldName.text,
           let email = registerScreen.textFieldEmail.text,
           let password = registerScreen.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    self.hideActivityIndicator()
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    
                    if let newUser = Auth.auth().currentUser {
//                        self.createUserDoc(user: newUser)
                    }
                } else {
                    self.showAccountAlreadyExists()
                }
            })
        }
    }
    
    @objc func onButtonRegisterClicked() {
        if registerScreen.textFieldName.text! == "" || registerScreen.textFieldPassword.text! == "" {
            showEmptyFields()
        }
        else if !isValidEmail(email: registerScreen.textFieldEmail.text!) {
            showInvalidEmail()
        }
        else if registerScreen.textFieldPassword.text! != registerScreen.textfieldConfirmPassword.text! {
            showPasswordNotMatching()
        }
        else if registerScreen.textFieldPassword.text!.count < 6 {
            showPasswordLengthError()
        }
        else {
            registerNewAccount()
            
        }
    }
    
//    func createUserDoc(user: FirebaseAuth.User) {
//        let userData = [
//            "displayName": user.displayName ?? "",
//            "email": user.email ?? "",
//        ]
//        
//        database.collection("users").document(user.uid).setData(userData) { error in
//            if let error = error {
//                print("Error creating user document: \(error)")
//            } else {
//                print("User document created successfully with ID: \(user.uid)")
//            }
//        }
//    }
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


