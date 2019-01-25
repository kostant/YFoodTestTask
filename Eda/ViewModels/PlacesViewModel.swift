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

protocol PlacesViewModelOutputs {
    var items: Observable<[PlaceCellViewModel]> { get }
    var isLoading: Observable<Bool> { get }
    var requestError: Observable<Void> { get }
}

protocol PlacesViewModelType {
    var inputs: PlacesViewModelInputs { get }
    var outputs: PlacesViewModelOutputs { get }
}

struct PlacesViewModel: PlacesViewModelInputs, PlacesViewModelOutputs, PlacesViewModelType {
    
    private let disposeBag = DisposeBag()
    
    //Inputs
    let viewDidLoad: AnyObserver<Void>
    let pulledToRefresh: AnyObserver<Void>
    let repeatClicked: AnyObserver<Void>
    let clearCacheClicked: AnyObserver<Void>
    
    //Outputs
    let items: Observable<[PlaceCellViewModel]>
    let isLoading: Observable<Bool>
    let requestError: Observable<Void>
    
    init(apiService: ApiServiceType, imageLoader: ImageLoader) {
        
        let action = Action<Void, [Place]> {
            return apiService.places(lat: 55.762885, lon: 37.597360)
                .observeOn(MainScheduler.instance)
        }
        
        viewDidLoad = action.inputs.asObserver()
        pulledToRefresh = action.inputs.asObserver()
        repeatClicked = action.inputs.asObserver()
        
        let imageWidth = String(Int(PlaceCell.imageWidth * UIScreen.main.scale))
        let imageHeight = String(Int(PlaceCell.imageHeight * UIScreen.main.scale))
        items = action.elements
            .map { places in
                return places.map {
                    let imagePath = $0.imagePath
                        .replacingOccurrences(of: "{w}", with: imageWidth)
                        .replacingOccurrences(of: "{h}", with: imageHeight)
                    return PlaceCellViewModel(
                        name: $0.name,
                        description: $0.description,
                        image: imageLoader.image(path: imagePath).startWith(nil)
                    )
                 }
            }
        
        isLoading = action.executing
        
        requestError = action.errors
            .filter {
                if case .underlyingError(_) = $0 {
                    return true
                } else {
                    return false
                }
            }
            .map {_ in}
        
        clearCacheClicked = AnyObserver { event in
            if case .next(_) = event {
                imageLoader.clearCache()
            }
        }
    }
    
    var inputs: PlacesViewModelInputs {
        return self
    }
    
    var outputs: PlacesViewModelOutputs {
        return self
    }
    
}
