//
//  OzeGitHubTest.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 30/03/2022.
//

import Foundation
import UIKit

class OzeGitHubTestCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Event) {
        switch type {
        case .moveToDetailPage(title: let title, dpImg: let dp, login: let login, id: let id):
          let vc:DatialPageViewController & Coordinating = DatialPageViewController(title: title, dpImg: dp, login: login, id: id)
          vc.coordinator = self
         navigationController?.pushViewController(vc, animated: true)
        case .moveToFavoritePage:
          let vc: FavoritesViewController = FavoritesViewController()
         navigationController?.pushViewController(vc, animated: true)
          break
        }
    }
    
    func start() {
        var vc:UIViewController & Coordinating = LandingViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    
    
}
