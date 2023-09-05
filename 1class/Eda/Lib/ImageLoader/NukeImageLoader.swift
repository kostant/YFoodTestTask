//
//  Nuke+ImageLoader.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import Foundation
import RxSwift
import Nuke

struct NukeImageLoader: ImageLoader {
    
    private let baseUrl: URL
    private let cache: Cache
    private let manager: Manager
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
        self.cache = Cache.shared
        self.manager = Manager(loader: Loader.shared, cache: cache)
    }
    
    func image(path: String) -> Observable<Image?> {
        guard let url = URL(string: path, relativeTo: baseUrl) else {
            return .just(nil)
        }
        return Observable.create { observer in
            Manager.shared.loadImage(with: url, completion: { result in
                if let image = result.value {
                    observer.onNext(image)
                } else {
                    observer.onNext(nil)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
        
    }
    
    func clearCache() {
        cache.removeAll()
    }
}
