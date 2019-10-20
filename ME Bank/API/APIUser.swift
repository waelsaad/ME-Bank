//
//  APIManager.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

final class APIUser: APIManager {
    
    static let shared: APIUser = APIUser()
    
    func getUserList<T: Decodable>(result: Int, page: Int,
                               completion: @escaping (Result<T, APIError>) -> Void) {
            self.request(url: EndPoint.getUserList(result: result,
                                              page: page).route,
                    completion: completion)
    }
}
