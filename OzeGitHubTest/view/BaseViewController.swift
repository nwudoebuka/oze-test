//
//  BaseViewController.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 30/03/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      setUpUI()
    }
 
  func setUpUI(){
    
  }
  
  func showMessage(_ title:String, _ msg:String){
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
