//
//  APIManager.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

class APIManager {
    
    private let jsonDecoder: JSONDecoder = { let jsonDecoder = JSONDecoder(); return jsonDecoder }()
    
    func request<T: Decodable>(url: URL?,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                    200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    //print(String.init(bytes: data, encoding: .utf8)!)
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch (let error) {
                    print(error)
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(.apiError(error.localizedDescription)))
            }
        }.resume()
    }
}
