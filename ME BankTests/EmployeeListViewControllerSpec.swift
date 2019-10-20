//
//  EmployeeListViewControllerSpec.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit
import Foundation

import Quick
import Nimble
import XCTest

@testable import ME_Bank

class EmployeeListViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("EmployeeListViewController") {
            
            var employeeCell: EmployeeItemTableViewCell!
            var viewController: EmployeeListViewController?
            
            
            beforeEach {
                let storyboard = UIStoryboard(name: "EmployeeList", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "EmployeeListViewController") as? EmployeeListViewController
                
                _ = viewController?.view
            }
            
            // MARK: - Table secion count test
            it("should have one section") {
                let sections = viewController?.tableView.numberOfSections
                expect(sections) == 1
            }
            
            // MARK: -
            
            context("When fetching users successfully") {
                
                viewController?.setup()
                viewController?.viewModel = EmployeeListViewModel()
                
                it("Employee Cell unfolding") {
                    viewController?.viewModel.getUsers(pageNumber: 1,
                                                       completion: { result in
                                                        switch result {
                                                        case .success:
                                                            let indexPath = IndexPath(row: 0, section: 0)
                                                            employeeCell = viewController?.tableView.cellForRow(at: indexPath) as? EmployeeItemTableViewCell
                                                            expect(employeeCell.isUnfolded).to(equal(false))
                                                            employeeCell.unfold(true)
                                                        case let .failure(error):
                                                            expect(error).notTo(beNil())
                                                        }
                    })
                }
            }
        }
    }
}

