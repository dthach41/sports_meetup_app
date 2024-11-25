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
    var textFieldAddress: UITextField!
    var labelDetails: UILabel!
    var textViewDetails: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTextFieldEventName()
        setupDatePickerEventDate()
        setupButtonSelectSportMenu()
        setupTextFieldAddress()
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
    
    func setupTextFieldAddress() {
        textFieldAddress = UITextField()
        textFieldAddress.placeholder = "Enter address of event..."
        textFieldAddress.borderStyle = .roundedRect
        textFieldAddress.layer.borderWidth = 0.5
        textFieldAddress.autocapitalizationType = .none
        textFieldAddress.autocorrectionType = .no
        textFieldAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAddress)
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
            
            textFieldAddress.topAnchor.constraint(equalTo: buttonSelectSportMenu.bottomAnchor, constant: 16),
            textFieldAddress.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            textFieldAddress.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textFieldAddress.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            labelDetails.topAnchor.constraint(equalTo: textFieldAddress.bottomAnchor, constant: 16),
            labelDetails.leadingAnchor.constraint(equalTo: textFieldAddress.leadingAnchor),
            
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
