//
//  EventDetailsView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/23/24.
//

import UIKit

class EventDetailsView: UIView {
    
    var imageIcon: UIImageView!
    var labelEventName: UILabel!
    var labelHost: UILabel!
    var buttonViewParticipants: UIButton!
    var labelParticipantsCount: UILabel!
    var participantsStack: UIStackView!
    var labelEventDate: UILabel!
    var labelAddress: UILabel!
    var labelDetails: UILabel!
    var buttonJoin: UIButton!
    var buttonEndEvent: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupImageIcon()
        setupLabelEventName()
        setupLabelHost()
        setupButtonViewParticipants()
        setupLabelParticipantsCount()
        setupParticipantsStack()
        setupLabelAddress()
        setupLabelEventDate()
        setupLabelDetails()
        setupButtonJoin()
        setupButtonEndEvent()
        
        initConstraints()
    }
    
    func setupImageIcon() {
        let image = UIImage(systemName: "figure.run.circle.fill")
        imageIcon = UIImageView(image: image!)
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageIcon)
    }
    
    func setupLabelEventName() {
        labelEventName = UILabel()
        labelEventName.text = ""
        labelEventName.font = .boldSystemFont(ofSize: 24)
        labelEventName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEventName)
    }
    
    func setupLabelHost() {
        labelHost = UILabel()
        labelHost.text = "Host: "
        labelHost.isUserInteractionEnabled = true
        labelHost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelHost)
    }
    
    func setupButtonViewParticipants() {
        buttonViewParticipants = UIButton(type: .system)
        buttonViewParticipants.setImage(UIImage(systemName:"person"), for: .normal)
        buttonViewParticipants.imageView?.contentMode = .scaleAspectFit
        buttonViewParticipants.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonViewParticipants)
        
        buttonViewParticipants.imageView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonViewParticipants.imageView!.widthAnchor.constraint(equalToConstant: 30),  // Larger image size inside the button
            buttonViewParticipants.imageView!.heightAnchor.constraint(equalToConstant: 30)  // Larger image size inside the button
        ])
    }

    
    func setupLabelParticipantsCount() {
        labelParticipantsCount = UILabel()
        labelParticipantsCount.font = .boldSystemFont(ofSize: 22)
        labelParticipantsCount.text = "Participants: 0"
        labelParticipantsCount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelParticipantsCount)
    }
    
    func setupParticipantsStack() {
        participantsStack = UIStackView(arrangedSubviews: [buttonViewParticipants, labelParticipantsCount])
        
        participantsStack.translatesAutoresizingMaskIntoConstraints = false
        participantsStack.axis = .horizontal
        participantsStack.spacing = 6 // Space between the image and label
        participantsStack.alignment = .center
        
        self.addSubview(participantsStack)
    }
    
    func setupLabelAddress() {
        labelAddress = UILabel()
        labelAddress.text = "Address:"
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress)
    }
    
    func setupLabelEventDate() {
        labelEventDate = UILabel()
        labelEventDate.text = "Date"
        labelEventDate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEventDate)
    }
    
    func setupLabelDetails() {
        labelDetails = UILabel()
        labelDetails.text = "Details"
        labelDetails.numberOfLines = 0
        labelDetails.lineBreakMode = .byWordWrapping
        labelDetails.textAlignment = .center
        labelDetails.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDetails)
    }
    
    func setupButtonJoin() {
        buttonJoin = UIButton(type: .system)
        buttonJoin.setTitle("Join", for: .normal)
        buttonJoin.setTitleColor(.white, for: .normal)
        buttonJoin.backgroundColor = .gray
        buttonJoin.layer.borderWidth = 1
        buttonJoin.layer.cornerRadius = 10
        buttonJoin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonJoin)
    }
    
    func setupButtonEndEvent() {
        buttonEndEvent = UIButton(type: .system)
        buttonEndEvent.setTitle("End Event", for: .normal)
        buttonEndEvent.setTitleColor(.white, for: .normal)
        buttonEndEvent.backgroundColor = .gray
        buttonEndEvent.layer.borderWidth = 1
        buttonEndEvent.layer.cornerRadius = 10
        buttonEndEvent.isHidden = true
        buttonEndEvent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEndEvent)
    }
    
    
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            labelEventName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            labelEventName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            imageIcon.topAnchor.constraint(equalTo: labelEventName.bottomAnchor, constant: 16),
            imageIcon.widthAnchor.constraint(equalToConstant: 70),
            imageIcon.heightAnchor.constraint(equalToConstant: 70),
            imageIcon.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            labelHost.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 12),
            labelHost.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            buttonViewParticipants.widthAnchor.constraint(equalToConstant: 30),
            buttonViewParticipants.heightAnchor.constraint(equalToConstant: 30),
            
            participantsStack.topAnchor.constraint(equalTo: labelHost.bottomAnchor, constant: 12),
            participantsStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            

            labelEventDate.topAnchor.constraint(equalTo: labelParticipantsCount.bottomAnchor, constant: 12),
            labelEventDate.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            labelAddress.topAnchor.constraint(equalTo: labelEventDate.bottomAnchor, constant: 12),
            labelAddress.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            labelDetails.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 12),
            labelDetails.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            labelDetails.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            labelDetails.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            buttonJoin.topAnchor.constraint(equalTo: labelDetails.bottomAnchor, constant: 24),
            buttonJoin.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonJoin.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 120),
            buttonJoin.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -120),
            buttonJoin.heightAnchor.constraint(equalToConstant: 40),
            
            buttonEndEvent.topAnchor.constraint(equalTo: buttonJoin.bottomAnchor, constant: 24),
            buttonEndEvent.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonEndEvent.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 120),
            buttonEndEvent.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -120),
            buttonEndEvent.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
