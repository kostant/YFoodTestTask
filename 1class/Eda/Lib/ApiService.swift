//
//  ApiService.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import RxSwift
import RxCocoa

struct ApiService: ApiServiceType {
    
    private let baseUrl: URL
    private let session = URLSession.shared
    private let parameterEncoder = URLEncoding()
    private let decoder = JSONDecoder()
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func places(lat: Double, lon: Double) -> Observable<[Place]> {
        let request = prepareRequest(route: .places(lat: lat, lon: lon))
        return session.rx.data(request: request)
            .map { [decoder] data in
                let response = try decoder.decode(Response<PlacesPayload>.self, from: data)
                return response.payload.foundPlaces
            }
    }
}

extension ApiService {
    private func prepareRequest(route: Route) -> URLRequest {
        let properties = route.requestProperties
        
        guard let url = URL(string: properties.path, relativeTo: baseUrl) else {
            fatalError("URL(string: \(properties.path), relativeToURL: \(baseUrl)) == nil")
        }
        var request = URLRequest(url: url)
        request.httpMethod = properties.method.rawValue
        if properties.method == .get {
            parameterEncoder.encode(&request, with: route.requestProperties.query)
        } else {
            guard let data = try? JSONSerialization.data(withJSONObject: route.requestProperties.query, options: []) else {
                fatalError()
            }
            request.httpBody = data
        }
        return request
    }
}

extension ApiService {
    private struct Response<T: Decodable>: Decodable {
        let payload: T
    }
    
    private struct PlacesPayload: Decodable {
        let foundPlaces: [Place]
    }
}
