//
//  URLSession.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
}

protocol Request {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension String: Request {
    var url: URL { return URL(string: self)! }
    var method: HTTPMethod { return .get }
    var headers: [String : String]? { return nil }
    var parameters: [String : String]? { return nil }
}

extension URLSession {
    
    func dataTask(with request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: prepareUrlRequest(from: request), completionHandler: completionHandler)
    }
    
    func dataTask<T: Decodable>(with request: Request, decoder: JSONDecoder, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try decoder.decode(T.self, from: data)
                    completionHandler(json, response, error)
                } catch {
                    completionHandler(nil, response, error)
                }
            } else {
                completionHandler(nil, response, error)
            }
        }
    }
    
    func dataTask(with request: Request, completionHandler: @escaping (Any?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(json, response, error)
                } catch {
                    completionHandler(nil, response, error)
                }
            } else {
                completionHandler(nil, response, error)
            }
        }
    }
    
    private func prepareUrlRequest(from request: Request) -> URLRequest {
        guard var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create url components from url: \(request.url.absoluteString)")
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.parameters?.forEach{ (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("Couldn't create url with these parameters")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers?.forEach{ (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}

extension URLSession {
    
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}


