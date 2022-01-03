//
//  ProductPageComponent.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 03.12.2021.
//

import Foundation
import NeedleFoundation
import XCoordinator
import CommonLogic
import SwiftyBeaver

public protocol CartDependency: Dependency {
    var productsRepository: ProductsRepository { get }
}

public class CartComponent: Component<CartDependency> {
    func domainModel(router: WeakRouter<CartRoute>) -> CartDomainModel {
        return CartDomainModel(repository: dependency.productsRepository, router: router)
    }
    
    public func coordinator(nextHandlerCallback: @escaping (CartRoute) -> Void) -> CartCoordinator {
        return CartCoordinator(component: self, nextHandlerCallback: nextHandlerCallback)
    }
    
    deinit {
        SwiftyBeaver.debug("deinit")
    }
}
