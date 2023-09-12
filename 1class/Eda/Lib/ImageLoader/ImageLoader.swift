//
//  ImageLoader.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import RxSwift

typealias Image = UIImage

protocol ImageLoader {
    func image(path: String) -> Observable<Image?>
    func clearCache()
}


