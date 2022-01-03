//
//  ProductListDomainModel.swift
//  WLNetworkClient
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import XCoordinator
import Combine
import CommonLogic

class ProductListDomainModel {
    // MARK: Output
    var products: AnyPublisher<[ProductValue], Never> {
        productsRepository.products
    }
    @Published private(set) var isLoading = false
    
    // MARK: Input
    private(set) lazy var onTapBackButton = Subscribers.MergeSink<Void> { [weak self] _ in
        self?.router.trigger(.flowFinished)
    }
    
    // MARK: Relays
    
    // MARK: State
    private var cancellableBag = Set<AnyCancellable>()
    private var getProductsRequest: AnyCancellable?
    
    // MARK: Dependencies
    private let router: UnownedRouter<ProductListRoute>
    private let productsRepository: ProductsRepository

    init(productsRepository: ProductsRepository, router: UnownedRouter<ProductListRoute>) {
        self.productsRepository = productsRepository
        self.router = router
        
        reloadProducts()
    }
    
    private func reloadProducts() {
        isLoading = true
        getProductsRequest?.cancel()
        getProductsRequest = productsRepository.reloadProducts()
            .sink(onResolved: { [weak self] _ in
                self?.isLoading = false
            })
    }
}
