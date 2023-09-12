//
//  Kingfisher+ImageLoader.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

struct KingfisherImageLoader: ImageLoader {
    
    private let baseUrl: URL
    private let manager: KingfisherManager
    
    init(baseUrl: URL, manager: KingfisherManager = KingfisherManager.shared) {
        self.baseUrl = baseUrl
        self.manager = manager
    }
    
    func image(path: String) -> Observable<Image?> {
        guard let url = URL(string: path, relativeTo: baseUrl) else {
            return .just(nil)
        }
        return Observable.create { observer in
            let task = self.manager.retrieveImage(with: url, options: nil, progressBlock: nil) { image, error, _, _ in
                if let image = image {
                    observer.onNext(image)
                } else {
                    observer.onNext(nil)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
    
    func clearCache() {
        manager.cache.clearMemoryCache()
        manager.cache.clearDiskCache()
    }
    
}
