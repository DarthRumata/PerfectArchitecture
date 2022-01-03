//
//  ProductPageViewModel.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 03.12.2021.
//

import Foundation
import XCoordinator
import CommonLogic
import SwiftyBeaver
import Combine

class CartDomainModel {
    // MARK: Input
    private(set) lazy var onTapCloseButton = Subscribers.MergeSink<Void> { [weak self] _ in
        self?.router.trigger(.flowFinished)
    }
    
    // MARK: Dependencies
    private let repository: ProductsRepository
    private let router: WeakRouter<CartRoute>
    
    init(repository: ProductsRepository, router: WeakRouter<CartRoute>) {
        self.repository = repository
        self.router = router
        SwiftyBeaver.debug("")
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }
}
