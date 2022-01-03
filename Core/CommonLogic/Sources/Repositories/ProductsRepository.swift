//
//  CommonItemsRepository.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 03.12.2021.
//

import Combine
import SwiftyBeaver

public class ProductsRepository {
    public var products: AnyPublisher<[ProductValue], Never> {
        storage.values
    }
    
    private let storage = EntityStorage<Product>()
    private let networkService: ProductsNetworkService
    
    public init(networkService: ProductsNetworkService) {
        self.networkService = networkService
        
        SwiftyBeaver.debug("")
    }
    
    public func reloadProducts() -> Future<[ProductValue], Error> {
        networkService.getProducts()
            .map { [weak self] products -> [ProductValue] in
                self?.storage.replaceAll(with: products)
                SwiftyBeaver.info(products)
                return products.map { $0.value }
            }
            .mapError { error -> Error in
                SwiftyBeaver.error(error)
                return error as Error
            }
            .asFuture()
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }
}
