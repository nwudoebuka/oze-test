//
//  MockService.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 05/04/2022.
//

import Foundation

final class MockCardService: Serviceable {

    var didGetUsers: Bool = false
    var getUsersClosure: ((Result<GitUserResponse, NetworkError>) -> ())!
  
  func getUsers(_ page: String, _ completion: @escaping (Result<GitUserResponse, NetworkError>) -> ()) {
    didGetUsers = true
    getUsersClosure = completion
  }
  
    func getUsersFailure() {
      getUsersClosure(.failure(NetworkError.notFound))
    }
    
    func getUsersSuccess() {
      let item = Item(login: "testLogin", id: 1, nodeID: "testNodeId", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", siteAdmin: false, score: 20)
        let getUsersResponse = GitUserResponse( items: [item])
      getUsersClosure(.success(getUsersResponse))
    }
    

}
