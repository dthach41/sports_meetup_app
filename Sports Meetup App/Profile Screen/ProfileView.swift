//
//  ProfileView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/6/24.
//

import UIKit

class ProfileView: UIView {
    
    var imageProfilePic: UIImageView!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelBio: UILabel!
    var labelFollowers: UILabel!
    var labelFollowing: UILabel!
    var labelLevel: UILabel!
    var buttonEdit: UIButton!
    var buttonFollow: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupImageProfilePic()
        setupLabelName()
        setupLabelEmail()
        setupLabelLevel()
        setupLabelFollowers()
        setupLabelFollowing()
        setupLabelBio()
        setupButtonEditProfile()
        setupButtonFollow()
        
        initConstraints()
    }
    
    func setupImageProfilePic() {
        imageProfilePic = UIImageView()
        imageProfilePic.image = UIImage(systemName: "person.circle.fill")
        imageProfilePic.tintColor = .black
        imageProfilePic.contentMode = .scaleToFill
        imageProfilePic.clipsToBounds = true
        imageProfilePic.layer.cornerRadius = 50
        imageProfilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageProfilePic)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Person"
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email@email.com"
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelBio() {
        labelBio = UILabel()
        labelBio.text = "BIO"
        labelBio.numberOfLines = 0
        labelBio.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelBio)
    }
    
    func setupLabelFollowers() {
        labelFollowers = UILabel()
        labelFollowers.font = .systemFont(ofSize: 16)
        labelFollowers.text = "Followers: 0"
        labelFollowers.isUserInteractionEnabled = true
        labelFollowers.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelFollowers)
    }
    
    func setupLabelFollowing() {
        labelFollowing = UILabel()
        labelFollowing.font = .systemFont(ofSize: 16)
        labelFollowing.text = "Following: 0"
        labelFollowing.isUserInteractionEnabled = true
        labelFollowing.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelFollowing)
    }
    
    func setupLabelLevel() {
        labelLevel = UILabel()
        labelLevel.text = "Level: 0"
        labelLevel.numberOfLines = 0
        labelLevel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelLevel)
    }
    
    func setupButtonEditProfile() {
        buttonEdit = UIButton(type: .system)
        buttonEdit.setTitle("Edit Profile", for: .normal)
        buttonEdit.backgroundColor = .systemBlue
        buttonEdit.tintColor = .white
        buttonEdit.layer.cornerRadius = 8
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEdit)
    }
    
    func setupButtonFollow() {
        buttonFollow = UIButton(type: .system)
        buttonFollow.setTitle("Follow", for: .normal)
        buttonFollow.backgroundColor = .systemBlue
        buttonFollow.tintColor = .white
        buttonFollow.layer.cornerRadius = 8
        buttonFollow.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonFollow)
    }
    
    func showEditButton() {
        buttonEdit.isHidden = false
        buttonFollow.isHidden = true
    }

    func showFollowButton() {
        buttonEdit.isHidden = true
        buttonFollow.isHidden = false
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
//            imageProfilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
//            imageProfilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            imageProfilePic.widthAnchor.constraint(equalToConstant: 100),
//            imageProfilePic.heightAnchor.constraint(equalToConstant: 100),
//
//            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
//            labelName.leadingAnchor.constraint(equalTo: imageProfilePic.trailingAnchor, constant: 20),
//            labelName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            
//            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
//            labelEmail.leadingAnchor.constraint(equalTo: imageProfilePic.trailingAnchor, constant: 20),
//            
//            labelBio.topAnchor.constraint(equalTo: imageProfilePic.bottomAnchor, constant: 20),
//            labelBio.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            labelBio.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),
//
//            buttonEdit.topAnchor.constraint(equalTo: labelBio.bottomAnchor, constant: 10),
//            buttonEdit.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            buttonFollow.topAnchor.constraint(equalTo: buttonEdit.bottomAnchor, constant: 10),
//            buttonFollow.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            // Profile Picture
                    imageProfilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                    imageProfilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    imageProfilePic.widthAnchor.constraint(equalToConstant: 100),
                    imageProfilePic.heightAnchor.constraint(equalToConstant: 100),
                    
                    // Name Label
                    labelName.topAnchor.constraint(equalTo: imageProfilePic.topAnchor),
                    labelName.leadingAnchor.constraint(equalTo: imageProfilePic.trailingAnchor, constant: 16),
                    labelName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    
                    // Email Label
                    labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
                    labelEmail.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
                    labelEmail.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),

                    // Followers, Following, Level (Horizontal Alignment)
                    labelFollowers.topAnchor.constraint(equalTo: imageProfilePic.bottomAnchor, constant: 20),
                    labelFollowers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    
                    labelFollowing.centerYAnchor.constraint(equalTo: labelFollowers.centerYAnchor),
                    labelFollowing.leadingAnchor.constraint(equalTo: labelFollowers.trailingAnchor, constant: 16),

                    labelLevel.centerYAnchor.constraint(equalTo: labelFollowers.centerYAnchor),
                    labelLevel.leadingAnchor.constraint(equalTo: labelFollowing.trailingAnchor, constant: 16),
                    labelLevel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),

                    // Bio
                    labelBio.topAnchor.constraint(equalTo: labelFollowers.bottomAnchor, constant: 16),
                    labelBio.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    labelBio.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),

                    // Buttons (Horizontally aligned)
                    buttonEdit.topAnchor.constraint(equalTo: labelBio.bottomAnchor, constant: 20),
                    buttonEdit.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    buttonEdit.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: -10),
                    buttonEdit.heightAnchor.constraint(equalToConstant: 44),
                    
                    buttonFollow.topAnchor.constraint(equalTo: labelBio.bottomAnchor, constant: 20),
                    buttonFollow.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 10),
                    buttonFollow.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    buttonFollow.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    ProfileView()
}
