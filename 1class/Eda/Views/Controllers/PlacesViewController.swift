//
//  ViewController.swift
//  Eda
//
//  Created by kost ant on 03.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import UIKit
import RxSwift

class PlacesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var clearBarButtonItem: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: PlacesViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        let cellIdent = "cell_place"
        tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: cellIdent)
        
        viewModel.outputs.items
            .bind(to: tableView.rx.items(cellIdentifier: cellIdent, cellType: PlaceCell.self)) { _, model, cell in
                cell.nameLabel.text = model.name
                cell.descriptionLabel.text = model.description
                model.image
                    .bind(to: cell.picImageView.rx.image)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.isLoading
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.outputs.requestError
            .subscribe(onNext: { [weak self] _ in
                self?.showErrorAlert()
            })
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.inputs.pulledToRefresh)
            .disposed(by: disposeBag)
        
        clearBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showClearAlert()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.onNext(())
        
    }

    func showErrorAlert() {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: "Что-то пошло не так, не удалось выполнить запрос.",
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        )
        alertController.addAction(
            UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
                self?.viewModel.inputs.repeatClicked.onNext(())
            })
        )
        present(alertController, animated: true, completion: nil)
    }
    
    func showClearAlert() {
        let alertController = UIAlertController(
            title: "Подтверждение",
            message: "Очистить кеш изображений?",
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        )
        alertController.addAction(
            UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
                self?.viewModel.inputs.clearCacheClicked.onNext(())
            })
        )
        present(alertController, animated: true, completion: nil)
    }

}

