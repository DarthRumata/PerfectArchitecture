//
//  ProductListFlowComponent.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import NeedleFoundation

public final class ProductPageFlowComponent: Component<EmptyDependency> {
    var productListComponent: ProductListComponent {
        return ProductListComponent(parent: self)
    }
    
    public func coordinator(navigationController: UINavigationController, nextRouteHandler: @escaping (ProductPageFlowRoute) -> Void) -> ProductPageFlowCoordinator {
        return ProductPageFlowCoordinator(navigationController: navigationController, component: self, nextRouteHandler: nextRouteHandler)
    }
}
