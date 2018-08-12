//
//  PlaceCellViewModel.swift
//  Eda
//
//  Created by kost ant on 05.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import RxSwift

struct PlaceCellViewModel {
    let name: String
    let description: String?
    let image: Observable<Image?>
}
