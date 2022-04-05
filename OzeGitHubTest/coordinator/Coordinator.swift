//
//  Coordinator.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 30/03/2022.
//

import Foundation
import Foundation
import UIKit
enum Event {
    case moveToFavoritePage
    case moveToDetailPage(title: String, dpImg: String, login: String, id: String)
    
}

protocol Coordinator {
    var navigationController:UINavigationController? {get set}
    func eventOccured(with type:Event)
    func start()
}

protocol Coordinating{
    var coordinator:Coordinator?{get set}
}
