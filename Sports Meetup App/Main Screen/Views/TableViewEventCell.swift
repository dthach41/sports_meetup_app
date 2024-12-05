//
//  TableViewEventCell.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 11/23/24.
//

import UIKit

class TableViewEventCell: UITableViewCell {
    var wrapperCellView: UIView!
    
    var verticalLine: UIView!
    
    var imageIcon: UIImageView!
    var labelEventName: UILabel!
    var labelHost: UILabel!
    var imageParticipants: UIImageView!
    var labelParticipantsCount: UILabel!
    var labelAddress: UILabel!
    var labelEventDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        
        setupVerticalLine()
        
        setupImageIcon()
        setupLabelEventName()
        setupLabelHost()
        setupImageParticipants()
        setupLabelParticipantsCount()
        setupLabelAddress()
        setupLabelEventDate()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.cornerRadius = 5
        wrapperCellView.backgroundColor = UIColor(red: 225 / 255, green: 229 / 255, blue: 230 / 255, alpha: 1.0)
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupImageIcon() {
        let image = UIImage(systemName: "figure.run.circle.fill")
        imageIcon = UIImageView(image: image!)
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageIcon)
    }
    
    func setupLabelHost() {
        labelHost = UILabel()
        labelHost.text = "Host: "
        labelHost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelHost)
    }
    
    func setupLabelEventName() {
        labelEventName = UILabel()
        labelEventName.text = ""
        labelEventName.font = .boldSystemFont(ofSize: 22)
        labelEventName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEventName)
    }
    
    func setupImageParticipants() {
        let image = UIImage(systemName: "person")
        imageParticipants = UIImageView(image: image!)
        imageParticipants.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageParticipants)
    }
    
    func setupLabelParticipantsCount() {
        labelParticipantsCount = UILabel()
        labelParticipantsCount.text = "1"
        // labelParticpantsCount will always be shown, everything else truncated if too long
        labelParticipantsCount.setContentCompressionResistancePriority(.required, for: .horizontal)
        labelParticipantsCount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelParticipantsCount)
    }
    
    func setupLabelAddress() {
        labelAddress = UILabel()
        labelAddress.text = "Address:"
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress)
    }
    
    func setupLabelEventDate() {
        labelEventDate = UILabel()
        labelEventDate.text = "00-00-0000"
        labelEventDate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEventDate)
    }
    
    func setupVerticalLine() {
        verticalLine = UIView()
        verticalLine.backgroundColor = .black
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(verticalLine)
    }
    

    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            imageIcon.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            imageIcon.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            imageIcon.widthAnchor.constraint(equalToConstant: 75),
            imageIcon.heightAnchor.constraint(equalToConstant: 75),
            
            
            labelEventName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelEventName.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            labelEventName.heightAnchor.constraint(equalToConstant: 20),
            labelEventName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            
            labelHost.topAnchor.constraint(equalTo: labelEventName.bottomAnchor, constant: 6),
            labelHost.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            labelHost.heightAnchor.constraint(equalToConstant: 20),
            
            
            labelAddress.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            labelAddress.topAnchor.constraint(equalTo: labelHost.bottomAnchor, constant: 6),
            labelAddress.heightAnchor.constraint(equalToConstant: 20),
            labelAddress.trailingAnchor.constraint(lessThanOrEqualTo: wrapperCellView.trailingAnchor),
            

            imageParticipants.centerYAnchor.constraint(equalTo: labelParticipantsCount.centerYAnchor),
            imageParticipants.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            imageParticipants.widthAnchor.constraint(equalToConstant: 20),
            imageParticipants.heightAnchor.constraint(equalToConstant: 20),
            imageParticipants.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 6),
            
            
            labelParticipantsCount.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -10),
            labelParticipantsCount.leadingAnchor.constraint(equalTo: imageParticipants.trailingAnchor, constant: 8),
            labelParticipantsCount.heightAnchor.constraint(equalToConstant: 20),
            labelParticipantsCount.trailingAnchor.constraint(equalTo: verticalLine.leadingAnchor, constant: -12),
            

            verticalLine.leadingAnchor.constraint(equalTo: labelParticipantsCount.trailingAnchor, constant: 12),
            verticalLine.heightAnchor.constraint(equalTo: labelParticipantsCount.heightAnchor),
            verticalLine.widthAnchor.constraint(equalToConstant: 1),
            verticalLine.centerYAnchor.constraint(equalTo: labelParticipantsCount.centerYAnchor),
            
            
            labelEventDate.leadingAnchor.constraint(equalTo: verticalLine.trailingAnchor, constant: 12),
            labelEventDate.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -10),
            labelEventDate.heightAnchor.constraint(equalToConstant: 20),
            labelEventDate.trailingAnchor.constraint(lessThanOrEqualTo: wrapperCellView.trailingAnchor),
            
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 118)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

