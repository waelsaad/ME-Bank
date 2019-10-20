//
//  APIEndpoints.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

enum EndPoint {
    
    case getUserList(result: Int, page: Int)
    
    var route: URL? {
        
        var items: [URLQueryItem]
        var components = URLComponents()
        components.host = Domains.Prod
        components.scheme = Scheme.https.rawValue
        components.path = "\(Routes.Api)"
        
        switch self {
    
        case .getUserList(let result, let page):
            
            let queryItems = [
                URLQueryItem(name: "results", value: result.description),
                URLQueryItem(name: "page", value: page.description)
            ]
            
            items = queryItems
            //components.path += "\(Path.results.rawValue)"
        }
        
        components.queryItems = items
        return components.url
    }
}

extension EndPoint {
    
//    private enum Path: String {
//        case results
//    }
    
    private enum Scheme: String {
        case http
        case https
    }
    
    private struct Routes {
        static let Api = "/api/1.2"
    }
    
    private struct Domains {
        static let Dev = "127.0.0.1:5000"
        static let Prod = "randomuser.me"
    }
}
