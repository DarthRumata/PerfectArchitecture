//
//  ProductListFlowCoordinator.swift
//  ProductPage
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

// swiftlint:disable file_length

import XCoordinator

public enum ProductPageFlowRoute: Route {
    case initial
    case popChildFlow
    
    case flowFinished(Presentable)
}

public final class ProductPageFlowCoordinator: NavigationCoordinator<ProductPageFlowRoute> {
    typealias RouteHandler = (ProductPageFlowRoute) -> Void

    private let component: ProductPageFlowComponent
    private let nextRouteHandler: RouteHandler

    init(navigationController: UINavigationController, component: ProductPageFlowComponent, nextRouteHandler: @escaping RouteHandler) {
        self.component = component
        self.nextRouteHandler = nextRouteHandler
        
        super.init(rootViewController: navigationController)
    }

    public override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .initial:
            let coordinator = component.productListComponent.coordinator { [weak self] route in
                guard let self = self else { return }
                switch route {
                case .flowFinished:
                    self.trigger(.flowFinished(self))
                }
                
            }
            return .push(coordinator)
            
        default:
            nextRouteHandler(route)
            return .none()
        }
    }
}
