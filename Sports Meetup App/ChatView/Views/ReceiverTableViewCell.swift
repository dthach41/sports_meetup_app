//
//  ReceiverTableViewCell.swift
//  Messenger App
//
//  Created by Jack Huang on 11/5/24.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelText: UILabel!
    var labelDateTime: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelText()
        setupLabelDateTime()
        
        initConstraints();
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .lightGray
        wrapperCellView.layer.cornerRadius = 16
        wrapperCellView.clipsToBounds = true
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrapperCellView)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 14)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelName)
    }
    
    func setupLabelText() {
        labelText = UILabel()
        labelText.font = UIFont.systemFont(ofSize: 16)
        labelText.textColor = .white
        labelText.numberOfLines = 0
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func setupLabelDateTime() {
        labelDateTime = UILabel()
        labelDateTime.font = UIFont.systemFont(ofSize: 12)
        labelDateTime.textColor = .lightGray
        labelDateTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDateTime)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            
            wrapperCellView.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 3),
            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            wrapperCellView.bottomAnchor.constraint(equalTo: labelDateTime.topAnchor, constant: -3),
            wrapperCellView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),

            labelText.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelText.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            labelText.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -10),

            labelDateTime.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelDateTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

