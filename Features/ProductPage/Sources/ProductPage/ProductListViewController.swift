//
//  ProductListViewController.swift
//  WLNetworkClient
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import Combine
import UIKit
import CommonUI
import SwiftUI

final class ProductListViewController: BaseController, Reusable {
    var domainModel: ProductListDomainModel!
    
    private lazy var embedController: UIHostingController<ProductListRootView> = {
        let viewModelsPublisher = self.domainModel.products
            .map { $0.map { ProductListCellModel(product: $0) } }
            .eraseToAnyPublisher()
        let isLoading = self.domainModel.$isLoading.eraseToAnyPublisher()
        let viewModel = ProductListViewModel(isLoading: isLoading, viewModels: viewModelsPublisher)
        let controller = UIHostingController(rootView: ProductListRootView(viewModel: viewModel))
        return controller
    }()
    private var cancellableBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureBindings()
    }

    private func configureUI() {
        addChild(embedController)
        view.addSubview(embedController.view)
        embedController.view?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            embedController.view.topAnchor.constraint(equalTo: view.topAnchor),
            embedController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            embedController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            embedController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureBindings() {
        navigationItem.leftBarButtonItem?.tapPublisher
            .publish(to: domainModel.onTapBackButton)
            .store(in: &cancellableBag)
    }
}
