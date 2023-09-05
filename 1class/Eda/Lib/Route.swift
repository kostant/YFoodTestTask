//
//  Route.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum Route {
    
    case places(lat: Double, lon: Double)
    
    var requestProperties: (method: HTTPMethod, path: String, query: [String: Any]) {
        switch self {
        case let .places(lat, lon):
            return (.get, "/api/v2/catalog", ["latitude": lat, "longitude": lon])
        }
    }
}
