//
//  DependencyContainer.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import UIKit

protocol ViewControllerFactory {
    func makePlacesViewController() -> UIViewController
}

class DependencyContainer {
    let apiService: ApiServiceType
    let imageLoader: ImageLoader
    
    init(apiService: ApiServiceType, imageLoader: ImageLoader) {
        self.apiService = apiService
        self.imageLoader = imageLoader
    }
    
}

extension DependencyContainer: ViewControllerFactory {
    func makePlacesViewController() -> UIViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "PlacesViewController") as! PlacesViewController
        let viewModel = PlacesViewModel(apiService: apiService, imageLoader: imageLoader)
        viewController.viewModel = viewModel
        return viewController
    }
}



