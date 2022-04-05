//
//  UserTableViewCell.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 30/03/2022.
//

import UIKit
import RealmSwift

class UserTableViewCell: UITableViewCell {
    
  static let identifier = "UserTableViewCell"
  var data:ItemsDTO?
  var realm = try! Realm()
  lazy var favoriteButton: UIButton = {
    let button = UIButton()
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.widthAnchor.constraint(equalToConstant: 50).isActive = true
    button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
    button.addTarget(self,action:#selector(favoriteClicked),
                     for:.touchUpInside)
    return button
  }()
  lazy var dpImage: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 40
    imageView.image = UIImage(named: "ic_avatar")
    imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    return imageView
  }()
  
  lazy var loginLabel: UILabel = {
    let label = UILabel.labelBold(text: "Login",textSize: 14,alignment: .left)
    return label
  }()
  
  lazy var loginValueLabel: UILabel = {
    let label = UILabel.labelRegular(text: "loginValue",textSize: 12, alignment: .left)
    return label
  }()
  
  lazy var labelStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.addArrangedSubview(loginLabel)
    stackView.spacing = 2
    stackView.addArrangedSubview(loginValueLabel)
    return stackView
  }()
  
  func configure(data:ItemsDTO){
    self.data = data
    setUpUI()
  }
  
  func setUpUI(){
    addSubview(dpImage)
    addSubview(labelStackView)
    addSubview(favoriteButton)
    
    dpImage.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil)
    dpImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    labelStackView.anchor(top: topAnchor, leading: dpImage.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 4))
    favoriteButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 12))
    
    if let userLogin = data?.login  {
      loginValueLabel.text = userLogin
    }

    if let avatarUrl = URL(string:data?.avatarUrl ?? String()){
    self.dpImage.downloadFromPath(from: avatarUrl)
    }
  }
  
  @objc func favoriteClicked(sender:UIButton)
  {
      let newFavorite = FavoritesDTO()
    newFavorite.avatarUrl = data?.avatarUrl ?? ""
    newFavorite.login = loginValueLabel.text ?? ""
    
    try! self.realm.write {
      self.realm.add(newFavorite)
    }
    
    favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  override func prepareForReuse() {
    
    favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
    
  }

}
