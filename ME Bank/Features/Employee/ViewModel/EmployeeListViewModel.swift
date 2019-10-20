//
//  EmployeeListViewModel.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

protocol EmployeeListViewModelType {
    var title: String { get }
    func getUsers(pageNumber: Int,
                  completion: @escaping (Result<Employees, APIError>) -> Void)
    func getUserList(result: Int, page: Int,
                     completion: @escaping (Result<Employees, APIError>) -> Void)
    func displayError(error: APIError)
}

class EmployeeListViewModel: EmployeeListViewModelType {

    var data: [EmployeeItemDisplayModel] = []
    
    var title: String {
        return "EMPLOYEELIST.NAVIGATION.TITLE".localized
    }

    init() {

    }

    func getUsers(pageNumber: Int,
                  completion: @escaping (Result<Employees, APIError>) -> Void) {
        getUserList(result: Constants.pageSizeMax,
                    page: pageNumber,
                    completion: completion)
    }
    
    func getUserList(result: Int, page: Int,
                     completion: @escaping (Result<Employees, APIError>) -> Void) {
        APIUser.shared.getUserList(result: result,
                                      page: page,
                                      completion: { (result: Result<Employees, APIError>) in
            switch result {
            case let .success(data):
                self.handleSuccess(data: data)
                completion(.success(data))
            case let .failure (error):
                completion(.failure(error))
            }
        })
    }
    
    func handleSuccess(data: Employees) {
        guard let employees = data.users else { return }
        for employee in employees {
            self.data.append(EmployeeItemDisplayModel(employee: employee))
        }
        
        pageNumber = data.info.page
        print (pageNumber)
    }

    func displayError(error: APIError) {
        UIAlert.display("EMPLOYEELIST.ALERT.TITLE".localized,
                        message: error.description,
                        buttons: ["EMPLOYEELIST.ALERT.CONFIRM".localized],
                        buttonsPreferredStyle: [.default]) { (alert, action) in
                            switch alert.style {
                            default:
                                break
                            }
        }
    }
    
    // MARK: - Private
    
    private var pageNumber = 1
}

extension EmployeeListViewModel {
    struct Constants {
        static let pageSizeMax = 20
        static let loadingOffset = 5
    }
}
