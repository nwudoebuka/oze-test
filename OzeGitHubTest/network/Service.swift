//
//  Service.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 02/04/2022.
//

import Foundation
import Combine

protocol Serviceable {
  func getUsers( _ page: String, _ completion: @escaping (Result<GitUserResponse,NetworkError>) -> ())
  
}

class Service {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - Serviceable
extension Service: Serviceable {
  
  func getUsers(_ page: String, _ completion: @escaping (Result<GitUserResponse, NetworkError>) -> ()) {
    
    let urlString = BaseUrl+page
    guard let url = URL(string: urlString) else{
      return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      guard data != nil else {
        return
      }
      do {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(GitUserResponse.self, from: data!)
        
        DispatchQueue.main.async {
          completion(.success(decodedData))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.unableToDeserialize))
        }
        
      }
      
    })
    task.resume()
  }
  
  
  
  
}
