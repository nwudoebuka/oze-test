//
//  OzeGitHubTestViewModel.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 02/04/2022.
//

import Foundation

class OzeGitHubTestViewModel: ObservableObject{
  @Published var gitUserResponse:GitUserResponse? = nil
  
  private let service: Serviceable

  init(
    service: Serviceable = Service()
  ) {
    self.service = service
   
  }
  
  func getGitUsers(page:String = "1", _ completion: @escaping (GitUserResponse?,NetworkError?) -> ()){
    service.getUsers(page, {val in
      
      switch val{
      case .success(let data):
        completion(data,nil)
        break
      case .failure(let error):
        completion(nil,error)
        break
      
        
      }
      
    })
  }
  
}
