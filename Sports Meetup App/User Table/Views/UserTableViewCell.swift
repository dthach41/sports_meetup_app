//
//  UserTableViewCell.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/4/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var imageProfilePic: UIImageView!
    var labelName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellVIew()
        setupImageProfilePic()
        setupLabelEmail()
        
        initConstraints()
    }
    
    func setupWrapperCellVIew() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupImageProfilePic() {
        imageProfilePic = UIImageView()
        imageProfilePic.image = UIImage(systemName: "person.circle.fill")
        imageProfilePic.contentMode = .scaleToFill
        imageProfilePic.clipsToBounds = true
        imageProfilePic.layer.cornerRadius = 50
        imageProfilePic.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageProfilePic)
    }
    
    func setupLabelEmail() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            imageProfilePic.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 2),
            imageProfilePic.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 2),
            imageProfilePic.widthAnchor.constraint(equalToConstant: 30),
            imageProfilePic.heightAnchor.constraint(equalToConstant: 30),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: imageProfilePic.leadingAnchor, constant: 16),
            labelName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant:  -16),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 34)
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
