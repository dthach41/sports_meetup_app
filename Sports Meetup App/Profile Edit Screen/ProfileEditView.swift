//
//  ProfileEditView.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/3/24.
//

import UIKit

class ProfileEditView: UIView {

    var imageProfilePic: UIImageView!
    var textFieldName: UITextField!
    var textFieldBio: UITextField!
    var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupImageProfilePic()
        setupTextFieldName()
        setupTextFieldBio()
        setupSaveButton()
        
        initConstraints()
    }
    
    func setupImageProfilePic() {
        imageProfilePic = UIImageView(image: Configs.defaultAvator)
        imageProfilePic.contentMode = .scaleAspectFill
        imageProfilePic.layer.cornerRadius = 50
        imageProfilePic.clipsToBounds = true
        imageProfilePic.isUserInteractionEnabled = true 
        imageProfilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageProfilePic)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.placeholder = "Enter Name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setupTextFieldBio() {
        textFieldBio = UITextField()
        textFieldBio.placeholder = "Enter Bio"
        textFieldBio.borderStyle = .roundedRect
        textFieldBio.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldBio)
    }
    
    func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 8
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            imageProfilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageProfilePic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageProfilePic.widthAnchor.constraint(equalToConstant: 100),
            imageProfilePic.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldName.topAnchor.constraint(equalTo: imageProfilePic.bottomAnchor, constant: 20),
            textFieldName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            textFieldBio.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 10),
            textFieldBio.leadingAnchor.constraint(equalTo: textFieldName.leadingAnchor),
            textFieldBio.trailingAnchor.constraint(equalTo: textFieldName.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: textFieldBio.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    ProfileEditView()
}
