//
//  SDWebImage+ImageLoader.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import Foundation
import RxSwift
import SDWebImage

struct SDWebImageLoader: ImageLoader {
    
    private let baseUrl: URL
    private let manager: SDWebImageManager
    
    init(baseUrl: URL, manager: SDWebImageManager = SDWebImageManager.shared()) {
        self.baseUrl = baseUrl
        self.manager = manager
    }
    
    func image(path: String) -> Observable<Image?> {
        guard let url = URL(string: path, relativeTo: baseUrl) else {
            return .just(nil)
        }
        return Observable.create { observer in
            let operation = self.manager.loadImage(with: url, options: [], progress: nil) { image, _, _, _, _, _ in
                if let image = image {
                    observer.onNext(image)
                } else {
                    observer.onNext(nil)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                operation?.cancel()
            }
        }
        
    }
    
    func clearCache() {
        manager.imageCache?.clearMemory()
        manager.imageCache?.clearDisk(onCompletion: nil)
    }
}
