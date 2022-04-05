//
//  FavoriteTableViewCell.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 31/03/2022.
//

import UIKit

protocol IfavoriteCellDelegate{
  func didRemoveAFavorite()
}

class FavoriteTableViewCell: UITableViewCell {
    
  static let identifier = "FavoriteTableViewCell"
  var delegate:IfavoriteCellDelegate?
  
  lazy var swipeToDelete: UILabel = {
    let label = UILabel.labelRegular(text: "Swipe to delete",textSize:7,textColor:.gray, alignment: .left)
    return label
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
    let label = UILabel.labelRegular(text: "value",textSize: 12, alignment: .left)
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
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(data: FavoritesDTO){
    if let url = URL(string: data.avatarUrl){
    dpImage.downloadFromPath(from: url)
    }
    loginValueLabel.text = data.login
    
  }
  
  @objc func removeFavoriteClicked(sender:UIButton)
  {
    delegate?.didRemoveAFavorite()
  }
  
  func setUpUI(){
    addSubview(dpImage)
    addSubview(labelStackView)
    addSubview(swipeToDelete)
    dpImage.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil)
    dpImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    labelStackView.anchor(top: topAnchor, leading: dpImage.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 4))
    swipeToDelete.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 12))
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

