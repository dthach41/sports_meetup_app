//
//  LoginView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/5/24.
//

import UIKit

class LoginView: UIView {
    
    var contentWrapper: UIScrollView!
    var labelAppName: UILabel!
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    var buttonForgotPassword: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLabelAppName()
        setuplabelEmail()
        setuptextFieldEmail()
        setupLabelPassword()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonRegister()
        setupButtonForgotPassword()
        
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupLabelAppName() {
        labelAppName = UILabel()
        labelAppName.text = "LevelUp \nSports"
        labelAppName.font = .boldSystemFont(ofSize: 36)
        labelAppName.numberOfLines = 0 // Allows the label to have multiple lines
        labelAppName.textAlignment = .center // Optional: Center the text if needed
        labelAppName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelAppName)
    }
    
    func setuplabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Username:"
        labelEmail.font = .systemFont(ofSize: 24)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelEmail)
    }
    
    func setuptextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.layer.borderWidth = 1
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldEmail)
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
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.backgroundColor = .gray
        buttonLogin.layer.borderWidth = 1
        buttonLogin.layer.cornerRadius = 10
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonLogin)
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
    
    func setupButtonForgotPassword() {
        buttonForgotPassword = UIButton(type: .system)
        buttonForgotPassword.setTitle("Forgot Password", for: .normal)
        buttonForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonForgotPassword)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            labelAppName.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 64),
            labelAppName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelAppName.bottomAnchor, constant: 24),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 24),
            labelPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textFieldPassword.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 24),
            buttonLogin.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 120),
            buttonLogin.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -120),
            buttonLogin.heightAnchor.constraint(equalToConstant: 40),
            
            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 24),
            buttonRegister.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 120),
            buttonRegister.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -120),
            buttonRegister.heightAnchor.constraint(equalToConstant: 40),
            
            buttonForgotPassword.topAnchor.constraint(equalTo: buttonRegister.bottomAnchor, constant: 16),
            buttonForgotPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonForgotPassword.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)
            
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

