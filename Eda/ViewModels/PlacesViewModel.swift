//
//  PlacesViewModel.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import RxSwift
import Action

protocol PlacesViewModelInputs {
    var viewDidLoad: AnyObserver<Void> { get }
    var pulledToRefresh: AnyObserver<Void> { get }
    var repeatClicked: AnyObserver<Void> { get }
    var clearCacheClicked: AnyObserver<Void> { get }
}
 // asaasaasa