//
//  ProductListComponent.swift
//  WLNetworkClient
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import NeedleFoundation
import CommonLogic

public protocol ProductListDependencies: Dependency {
    var productsRepository: ProductsRepository { get }
}

final class ProductListComponent: Component<ProductListDependencies> {
    func coordinator(nextRouteHandler: @escaping (ProductListRoute) -> Void) -> ProductListCoordinator {
        return ProductListCoordinator(component: self, nextRouteHandler: nextRouteHandler)
    }
}
