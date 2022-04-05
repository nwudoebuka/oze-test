//
//  FavoritesViewController.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 31/03/2022.
//

import UIKit
import RealmSwift

class FavoritesViewController: BaseViewController{
  
  var realm = try! Realm()
  var favoriteData:[FavoritesDTO]?
  
  private let parentTableView : UITableView = {
    let tableView = UITableView()
    tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    tableView.rowHeight = 90
    tableView.tableFooterView = UIView()
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Favorites"
    view.backgroundColor = .white
    parentTableView.delegate = self
    parentTableView.dataSource = self
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Clear All", style: .done, target: self, action: #selector(clearAllClicked))
  }
  
  @objc func clearAllClicked(sender: UIBarButtonItem)
  {
    
    guard let favelist = favoriteData else{
      return
    }
    
    for fave in favelist{
      try! realm.write {
        realm.delete(fave)
      }
      getSavedFavorites()
    }
    
  }
  
  func getSavedFavorites(){
    let savedFavorites = realm.objects(FavoritesDTO.self)
    self.favoriteData = savedFavorites.map{
      $0
    }
    self.favoriteData = self.favoriteData?.sorted { $0.login < $1.login }
    parentTableView.reloadData()
  }
  override func setUpUI() {
    view.addSubview(parentTableView)
    parentTableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
    getSavedFavorites()
  }
  
}

extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let count = favoriteData?.count else{
      
      return 0
    }
    if count == 0{
      DispatchQueue.main.async{
        self.showMessage("No Favorites", "Your favorite list is empty")
      }
      
    }
    return count
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let RemoveAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
      self.removeFavorite(indexPath.row)
      success(true)
    })
    RemoveAction.backgroundColor = .red
    
    return UISwipeActionsConfiguration(actions: [RemoveAction])
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = parentTableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier) as? FavoriteTableViewCell
    let bgColorView = UIView()
    bgColorView.backgroundColor = .clear
    cell?.selectedBackgroundView = bgColorView
    if let dto = favoriteData?[indexPath.row]{
      cell?.configure(data: dto)
    }
    return cell ?? UITableViewCell()
  }
  
  func removeFavorite(_ index:Int) {
    if let dataToRemove = favoriteData?[index]{
      try! realm.write {
        realm.delete(dataToRemove)
      }
      getSavedFavorites()
    }
  }
  
}
