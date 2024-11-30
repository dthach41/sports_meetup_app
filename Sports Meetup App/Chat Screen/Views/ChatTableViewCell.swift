//
//  ChatTableViewCell.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 11/29/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelReceiverName: UILabel!
    var labelLastMessage: UILabel!
    var labelLastMessageTime: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelReceiverName()
        setupLabelLastMessage()
        setupLabelLastMessageTime()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
//        wrapperCellView.layer.cornerRadius = 4.0
//        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
//        wrapperCellView.layer.shadowOffset = .zero
//        wrapperCellView.layer.shadowRadius = 2.0
//        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelReceiverName() {
        labelReceiverName = UILabel()
        labelReceiverName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelReceiverName)
    }
    
    func setupLabelLastMessage() {
        labelLastMessage = UILabel()
        labelLastMessage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLastMessage)
    }
    
    func setupLabelLastMessageTime() {
        labelLastMessageTime = UILabel()
        labelLastMessageTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLastMessageTime)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            labelReceiverName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelReceiverName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            labelReceiverName.heightAnchor.constraint(equalToConstant: 16),
            labelReceiverName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: -70),
            
            labelLastMessageTime.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelLastMessageTime.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            labelLastMessageTime.heightAnchor.constraint(equalToConstant: 16),
            labelLastMessageTime.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: -70),

            labelLastMessage.topAnchor.constraint(equalTo: labelReceiverName.topAnchor, constant: 25),
            labelLastMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            labelLastMessage.heightAnchor.constraint(equalToConstant: 16),
            labelLastMessage.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: -70),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
