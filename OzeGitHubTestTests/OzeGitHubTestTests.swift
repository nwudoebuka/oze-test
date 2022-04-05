//
//  OzeGitHubTestTests.swift
//  OzeGitHubTestTests
//
//  Created by WEMABANK on 30/03/2022.
//

import XCTest
@testable import OzeGitHubTest

class OzeGitHubTestTests: XCTestCase {
  var viewModel : OzeGitHubTestViewModel!
  var mockNetworkingService: MockCardService!
    override func setUpWithError() throws {
      mockNetworkingService = MockCardService()
      viewModel = OzeGitHubTestViewModel(service:mockNetworkingService)
     
    }

    override func tearDown() {
      viewModel = nil
      mockNetworkingService = nil
      super.tearDown()
    }

  func test_getUsersSuccess() {
    viewModel.getGitUsers(){
      data,error in
      self.mockNetworkingService.getUsersSuccess()
      XCTAssert(self.mockNetworkingService.didGetUsers)
    }
     
  }
  func test_getUsersFailure() {
    viewModel.getGitUsers(){
      data,error in
      self.mockNetworkingService.getUsersFailure()
      XCTAssert(self.mockNetworkingService.didGetUsers)
    }
  }

}
