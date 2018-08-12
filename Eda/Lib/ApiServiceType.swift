//
//  ApiServiceType.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import RxSwift

protocol ApiServiceType {
    func places(lat: Double, lon: Double) -> Observable<[Place]>
}
