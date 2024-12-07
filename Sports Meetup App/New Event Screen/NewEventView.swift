//
//  NewEventView.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/19/24.
//

import UIKit

class NewEventView: UIView {
    
    var textFieldEventName: UITextField!
    var datePickerEventDate: UIDatePicker!
    var buttonSelectSportMenu: UIButton!
    var buttonOpenMap: UIButton!
    var labelDetails: UILabel!
    var textViewDetails: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTextFieldEventName()
        setupDatePickerEventDate()
        setupButtonSelectSportMenu()
        setupButtonOpenMap()
        setupLabelDetails()
        setupTextViewDetails()
        
        initConstraints()
    }
    
    func setupTextFieldEventName() {
        textFieldEventName = UITextField()
        textFieldEventName.placeholder = "Event Name.."
        textFieldEventName.borderStyle = .roundedRect
        textFieldEventName.layer.borderWidth = 0.5
        textFieldEventName.autocapitalizationType = .none
        textFieldEventName.autocorrectionType = .no
        textFieldEventName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEventName)
    }
    
    func setupDatePickerEventDate() {
        datePickerEventDate = UIDatePicker()
        datePickerEventDate.datePickerMode = .dateAndTime
        datePickerEventDate.layer.cornerRadius = 5
        datePickerEventDate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(datePickerEventDate)
    }
    
    
    func setupButtonSelectSportMenu() {
        buttonSelectSportMenu = UIButton(type: .system)
        buttonSelectSportMenu.showsMenuAsPrimaryAction = true
        buttonSelectSportMenu.setTitle("Select Sport", for: .normal)
        buttonSelectSportMenu.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectSportMenu)
    }
    
    
    func setupButtonOpenMap() {
        buttonOpenMap = UIButton(type: .system)
        buttonOpenMap.setTitle("Select Location", for: .normal)
        buttonOpenMap.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonOpenMap)
    }
    
    func setupLabelDetails() {
        labelDetails = UILabel()
        labelDetails.text = "Details:"
        labelDetails.font = .systemFont(ofSize: 24)
        labelDetails.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDetails)
    }
    
    func setupTextViewDetails() {
        textViewDetails = UITextView()
        textViewDetails.layer.borderColor = UIColor.gray.cgColor
        textViewDetails.font = UIFont.systemFont(ofSize: 16)
        textViewDetails.layer.borderWidth = 1
        textViewDetails.layer.cornerRadius = 5
        textViewDetails.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textViewDetails)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            textFieldEventName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                                   constant: 16),
            textFieldEventName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            textFieldEventName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textFieldEventName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            datePickerEventDate.topAnchor.constraint(equalTo: textFieldEventName.bottomAnchor, constant: 16),
            datePickerEventDate.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            
            buttonSelectSportMenu.topAnchor.constraint(equalTo: datePickerEventDate.bottomAnchor, constant: 16),
            buttonSelectSportMenu.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            buttonOpenMap.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonOpenMap.topAnchor.constraint(equalTo: buttonSelectSportMenu.bottomAnchor, constant: 16),
            
            labelDetails.topAnchor.constraint(equalTo: buttonOpenMap.bottomAnchor, constant: 16),
            labelDetails.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            textViewDetails.topAnchor.constraint(equalTo: labelDetails.bottomAnchor, constant: 16),
            textViewDetails.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            textViewDetails.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textViewDetails.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24)
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
