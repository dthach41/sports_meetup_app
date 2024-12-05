//
//  ParticipantTableViewCell.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 12/5/24.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    
    var labelName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        
        setupLabelName()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.cornerRadius = 5
//        wrapperCellView.backgroundColor = UIColor(red: 225 / 255, green: 229 / 255, blue: 230 / 255, alpha: 1.0)
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = ""
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            labelName.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            labelName.centerXAnchor.constraint(equalTo: wrapperCellView.centerXAnchor),
            labelName.heightAnchor.constraint(equalToConstant: 40),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
