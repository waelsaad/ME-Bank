//
//  EmployeeListViewModelSpec.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit

import Quick
import Nimble

@testable import ME_Bank

final class EmployeeListViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("a view model for the Employee List screen") {
            
            var viewModel: EmployeeListViewModelType!
            
            beforeEach {
                viewModel = EmployeeListViewModel()
            }
            
            afterEach {
                viewModel = nil
            }
            
            it("has title for navigation bar") {
                expect(viewModel.title).to(equal("Employee List"))
            }
            
            context("When fetching users successfully") {
                it("returns http success") {
                    var requestError: Error!
                    viewModel.getUsers(pageNumber: 1,
                                       completion: { result in
                        switch result {
                        case let .success(data):
                            expect(requestError).to(beNil())
                            expect(data.users?.count).to(beGreaterThanOrEqualTo(0))
                        case let .failure(error):
                            requestError = error
                            expect(error).notTo(beNil())
                        }
                    })
                }
            }
            
            context("When testing API Response") {
                
                let mockAPIUser: MockAPIUser! = MockAPIUser()
                
                it("returns error on invalid endpoint") {
                    mockAPIUser.getUserList(completion: { result in
                                        switch result {
                                        case let .success(data):
                                            expect(data).to(beNil())
                                        case let .failure(error):
                                            expect(error).notTo(beNil())
                                            expect(error.description).to(equal("Could not reach API successfully"))
                                        }
                    })
                }

                it("returns alert message on empty records") {
                    mockAPIUser.getUserList(result: 0, completion: { result in
                        switch result {
                        case let .success(data):
                            expect(data).to(beNil())
                        case let .failure(error):
                            expect(error).notTo(beNil())
                            expect(error.description).to(equal("Could not find data"))
                        }
                    })
                }
            }
        }
    }
}

private final class MockUserList {
    func getUserList() -> [User] {
        return [User(name: Name(name: "Wael", lastName: "Saad"),
                     dob: BirthDay(date: "/Date(1563327564000+1000)/", age: 37),
                     gender: Gender.male,
                     picture: nil)]
    }
}

private final class MockAPIUser: APIManager {
    func getUserList(completion: @escaping (Result<[User], APIError>) -> Void) {
        self.request(url: URL(string: "http://randomuser.me/incorrect"),
                            completion: completion)
    }
    
    func getUserList(result: Int, completion: @escaping (Result<[User], APIError>) -> Void) {
        self.request(url: EndPoint.getUserList(result: result, page: 1).route,
                     completion: completion)
    }
}
