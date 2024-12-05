//
//  RegisterView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit

class RegisterView: UIView {
    
    var contentWrapper: UIScrollView!
    
    var labelRegister: UILabel!
    var labelName: UILabel!
    var textFieldName: UITextField!
    var labelProfilePicture: UILabel!
    var buttonSelectPicture: UIButton!
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPhoneNumber: UILabel!
    var textFieldPhoneNumber: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var labelConfirmPassword: UILabel!
    var textfieldConfirmPassword: UITextField!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupLabelRegister()
        setupLabelName()
        setupTextFieldName()
        setupLabelProfilePicture()
        setupButtonSelectPicture()
        setupLabelEmail()
        setupTextFieldEmail()
        setupLabelPhoneNumber()
        setupTextFieldPhoneNumber()
        setupLabelPassword()
        setupTextFieldPassword()
        setupLabelConfirmPassword()
        setupTextFieldConfirmPassword()
        setupButtonRegister()
        
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    
    func setupLabelRegister() {
        labelRegister = UILabel()
        labelRegister.text = "Register"
        labelRegister.font = .boldSystemFont(ofSize: 36)
        labelRegister.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelRegister)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name"
        labelName.font = .systemFont(ofSize: 24)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelName)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.borderStyle = .roundedRect
        textFieldName.layer.borderWidth = 1
        textFieldName.autocapitalizationType = .none
        textFieldName.autocorrectionType = .no
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldName)
    }
    
    func setupLabelProfilePicture() {
        labelProfilePicture = UILabel()
        labelProfilePicture.text = "Select Profile Picture:"
        labelProfilePicture.font = .systemFont(ofSize: 18)
        labelProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelProfilePicture)
    }
    
    func setupButtonSelectPicture() {
        buttonSelectPicture = UIButton(type: .system)
        buttonSelectPicture.setTitle("", for: .normal)
        buttonSelectPicture.showsMenuAsPrimaryAction = true
        buttonSelectPicture.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        buttonSelectPicture.contentHorizontalAlignment = .fill
        buttonSelectPicture.contentVerticalAlignment = .fill
        buttonSelectPicture.imageView?.contentMode = .scaleAspectFit
        buttonSelectPicture.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectPicture)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email:"
        labelEmail.font = .systemFont(ofSize: 24)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelEmail)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.layer.borderWidth = 1
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.autocorrectionType = .no
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldEmail)
    }
    
    
    func setupLabelPhoneNumber() {
        labelPhoneNumber = UILabel()
        labelPhoneNumber.text = "Phone Number:"
        labelPhoneNumber.font = .systemFont(ofSize: 24)
        labelPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelPhoneNumber)
    }
    
    func setupTextFieldPhoneNumber() {
        textFieldPhoneNumber = UITextField()
        textFieldPhoneNumber.borderStyle = .roundedRect
        textFieldPhoneNumber.keyboardType = .phonePad
        textFieldPhoneNumber.layer.borderWidth = 1
        textFieldPhoneNumber.autocapitalizationType = .none
        textFieldPhoneNumber.autocorrectionType = .no
        textFieldPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPhoneNumber)
    }
    
    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.text = "Password:"
        labelPassword.font = .systemFont(ofSize: 24)
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelPassword)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.layer.borderWidth = 1
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupLabelConfirmPassword() {
        labelConfirmPassword = UILabel()
        labelConfirmPassword.text = "Confirm Password:"
        labelConfirmPassword.font = .systemFont(ofSize: 24)
        labelConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelConfirmPassword)
    }
    
    func setupTextFieldConfirmPassword() {
        textfieldConfirmPassword = UITextField()
        textfieldConfirmPassword.borderStyle = .roundedRect
        textfieldConfirmPassword.layer.borderWidth = 1
        textfieldConfirmPassword.isSecureTextEntry = true
        textfieldConfirmPassword.autocapitalizationType = .none
        textfieldConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textfieldConfirmPassword)
    }

    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.backgroundColor = .gray
        buttonRegister.layer.borderWidth = 1
        buttonRegister.layer.cornerRadius = 10
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonRegister)
    }
    

    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            labelRegister.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
            labelRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelName.topAnchor.constraint(equalTo: labelRegister.bottomAnchor, constant: 24),
            labelName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            textFieldName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldName.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textFieldName.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            labelProfilePicture.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 24),
            labelProfilePicture.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            buttonSelectPicture.topAnchor.constraint(equalTo: labelProfilePicture.bottomAnchor, constant: 8),
            buttonSelectPicture.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonSelectPicture.widthAnchor.constraint(equalToConstant: 100),
            buttonSelectPicture.heightAnchor.constraint(equalToConstant: 100),
            
            labelEmail.topAnchor.constraint(equalTo: buttonSelectPicture.bottomAnchor, constant: 24),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            labelPhoneNumber.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 24),
            labelPhoneNumber.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldPhoneNumber.topAnchor.constraint(equalTo: labelPhoneNumber.bottomAnchor, constant: 16),
            textFieldPhoneNumber.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPhoneNumber.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textFieldPhoneNumber.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldPhoneNumber.bottomAnchor, constant: 24),
            labelPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textFieldPassword.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            labelConfirmPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 24),
            labelConfirmPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textfieldConfirmPassword.topAnchor.constraint(equalTo: labelConfirmPassword.bottomAnchor, constant: 16),
            textfieldConfirmPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textfieldConfirmPassword.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textfieldConfirmPassword.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            buttonRegister.topAnchor.constraint(equalTo: textfieldConfirmPassword.bottomAnchor, constant: 24),
            buttonRegister.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 120),
            buttonRegister.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -120),
            buttonRegister.heightAnchor.constraint(equalToConstant: 40),
            buttonRegister.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -16)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

