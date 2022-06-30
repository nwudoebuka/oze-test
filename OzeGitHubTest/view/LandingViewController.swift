//
//  LandingViewController.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 30/03/2022.
//

import UIKit
import RealmSwift

class LandingViewController: BaseViewController,Coordinating{
  
  var coordinator: Coordinator?
  var realm = try! Realm()
  var page = 1
  var isFetching = false
  var viewModel:OzeGitHubTestViewModel = OzeGitHubTestViewModel()
  var usersData:[ItemsDTO]?
  private let parentTableView : UITableView = {
       let tableView = UITableView()
    tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    tableView.rowHeight = 90
       return tableView
   }()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    title = ""
    view.backgroundColor = .white
    parentTableView.delegate = self
    parentTableView.dataSource = self
    getSavedData()
    }
  
  func getLagosUsers(_ str:String = "1"){
    
    isFetching = true
    viewModel.getGitUsers(page:str){
      data,error in
      self.isFetching = false
      guard let errorValue = error?.rawValue else{
        if let userDTO = data{
         
          let newList:[ItemsDTO]? =  userDTO.items.map {
            let newdata = ItemsDTO()
            newdata.avatarUrl = $0.avatarURL
            newdata.login = $0.login
            newdata.id = $0.id
            if let containsUserAlready = self.usersData?.contains(newdata) {
              if !containsUserAlready{
                self.usersData?.append(newdata)
              }
            }
           
            return newdata
          }
          
          self.saveUsers()
        }
          return
        }
        self.showMessage("Failed", errorValue)
  
    }
    
  }
  
  func saveUsers(){
    guard let dataToWrite = self.usersData else{
      return
    }
    
    try! self.realm.write {
      self.realm.add(dataToWrite)
    }
    self.usersData = dataToWrite
    self.createSpinerFooter(shouldAddSpinner: false)
    self.page = self.page + 1
    self.usersData = self.usersData?.sorted { $0.login < $1.login }
    self.loadTableView()
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }


  
  func loadTableView(){
    DispatchQueue.main.async {
    self.parentTableView.reloadData()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Favorites", style: .done, target: self, action: #selector(favoriteClicked))
  }
  func getSavedData(){
    
    let savedData = realm.objects(ItemsDTO.self)
    
    self.usersData = savedData.map {
      $0
    }
    self.usersData = self.usersData?.sorted { $0.login < $1.login }
    loadTableView()
    getLagosUsers()
  }
  
  override func setUpUI() {
    view.addSubview(parentTableView)
    parentTableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
  }

  @objc func favoriteClicked(sender: UIBarButtonItem)
  {
    coordinator?.eventOccured(with: .moveToFavoritePage)
  }

  
}

extension LandingViewController:UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return usersData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = parentTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as? UserTableViewCell
    let bgColorView = UIView()
    bgColorView.backgroundColor = .clear
    cell?.selectedBackgroundView = bgColorView
    if let userDTO = usersData{
    cell?.configure(data: userDTO[indexPath.row])
    }
    return cell ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    coordinator?.eventOccured(with: .moveToDetailPage(title: usersData?[indexPath.row].login ?? "", dpImg: usersData?[indexPath.row].avatarUrl ?? "", login: usersData?[indexPath.row].login ?? "", id: String((usersData?[indexPath.row].id)!)))
  }
  
  func createSpinerFooter(shouldAddSpinner:Bool = true) -> UIView?{
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
    let spinner = UIActivityIndicatorView()
    spinner.center = footerView.center
    DispatchQueue.main.async {
    spinner.startAnimating()
    }
    footerView.addSubview(spinner)
    if !shouldAddSpinner{
      parentTableView.tableFooterView = UIView()
      return nil
    }
    return footerView
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let position = scrollView.contentOffset.y
    if position > (parentTableView.contentSize.height - 100 - scrollView.frame.size.height){
      // fetch more
      parentTableView.tableFooterView = createSpinerFooter()
      if !isFetching{
      getLagosUsers(String(page + 1))
      }
    }
    
  }
  
  
}
