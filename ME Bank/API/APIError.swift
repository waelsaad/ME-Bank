//
//  APIError.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

enum APIError: Error, Equatable {
    case apiError(String)
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

// TODO: The error descriptions could be localized
extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .apiError:
            return "EMPLOYEELIST.API.ERROR.API.ERROR".localized
        case .invalidEndpoint:
            return "EMPLOYEELIST.API.ERROR.INVALID.ENDPOINT".localized
        case .invalidResponse:
            return "EMPLOYEELIST.API.ERROR.INVALID.RESPONSE".localized
        case .noData:
            return "EMPLOYEELIST.API.ERROR.NO.DATA".localized
        case .decodeError:
            return "EMPLOYEELIST.API.ERROR.DECODE.ERROR".localized
        }
    }
}
