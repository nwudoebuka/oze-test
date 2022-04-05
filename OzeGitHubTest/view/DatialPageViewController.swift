//
//  DatialPageViewController.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 31/03/2022.
//

import UIKit

class DatialPageViewController: BaseViewController,Coordinating {
  var coordinator: Coordinator?
  var userImg:UIImage?
  var login:String?
  var ID:String?
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
    let label = UILabel.labelRegular(text: "login",textSize: 14,alignment: .center)
    return label
  }()
  
  lazy var idLabel: UILabel = {
    let label = UILabel.labelRegular(text: "ID",textSize: 14,alignment: .center)
    return label
  }()
  
  lazy var dobLabel: UILabel = {
    let label = UILabel.labelRegular(text: "DOB",textSize: 14,alignment: .center)
    return label
  }()
  
  lazy var detailsStackV: UIStackView = {
    let stackView = UIStackView()
    stackView.addArrangedSubview(loginLabel)
    stackView.addArrangedSubview(idLabel)
    stackView.addArrangedSubview(dobLabel)
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 8
    return stackView
  }()
  
  override func viewDidLoad() {
  super.viewDidLoad()
    
    }
    
  init(title:String,dpImg:String,login:String,id:String) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
    if let url = URL(string: dpImg){
    self.dpImage.downloadFromPath(from: url)
    }
    self.loginLabel.text = login
    self.idLabel.text = id
    view.backgroundColor = .white
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setUpUI() {
    view.addSubview(dpImage)
    view.addSubview(detailsStackV)
    dpImage.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
    dpImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    detailsStackV.anchor(top: dpImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 40, left: 12, bottom: 0, right: 12))
    
  }

  
}
