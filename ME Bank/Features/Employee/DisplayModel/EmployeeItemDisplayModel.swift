//
//  EmployeeItemDisplayModel.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit
import Foundation

protocol EmployeeDisplayModelType {
    var name: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var gender: String { get set }
    var dateOfBirth: String { get set }
    var thumbnailUrl: URL? { get set }
    var largeImageUrl: URL? { get set }
}

final class EmployeeItemDisplayModel: EmployeeDisplayModelType {
    init(employee: User) {
        self.employee = employee
        name = employee.name.fullName
        firstName = employee.name.firstName.capitalized
        lastName = employee.name.lastName.capitalized
        gender = employee.gender.rawValue.capitalized
        dateOfBirth = employee.dateOfBirth
        thumbnailUrl = employee.picture?.thumbnailUrl
        largeImageUrl = employee.picture?.largeImageUrl
    }
    
    // MARK: - EmployeeDisplayModelType conformance

    var name: String
    var gender: String
    var dateOfBirth: String
    var thumbnailUrl: URL?
    var largeImageUrl: URL?
    var firstName: String
    var lastName: String
    
    // MARK: - Private
    
    private let employee: User
}

