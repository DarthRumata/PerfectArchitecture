//
//  ProductListCoordinator.swift
//  WLNetworkClient
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import XCoordinator
import SwiftyBeaver

enum ProductListRoute: Route {
    case flowFinished
}

final class ProductListCoordinator: ViewCoordinator<ProductListRoute> {
    typealias RouteHandler = (ProductListRoute) -> Void

    private let component: ProductListComponent
    private let nextRouteHandler: RouteHandler

    init(component: ProductListComponent, nextRouteHandler: @escaping RouteHandler) {
        self.component = component
        self.nextRouteHandler = nextRouteHandler
        
        let viewController = ProductListViewController.loadFromNib()
        
        super.init(rootViewController: viewController)
        
        let domainModel = ProductListDomainModel(productsRepository: component.dependency.productsRepository, router: unownedRouter)
        viewController.domainModel = domainModel
        SwiftyBeaver.debug("")
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        nextRouteHandler(route)
        return .none()
    }
}
