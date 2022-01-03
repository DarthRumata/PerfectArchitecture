//
//  BaseFlowComponent.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 07.12.2021.
//

import Foundation
import NeedleFoundation
import ProductPage
import Cart

class BaseFlowComponent: Component<EmptyDependency> {
    func coordinator(navigationController: UINavigationController, nextRouteHandler: @escaping (BaseFlowRoute) -> Void) -> BaseFlowCoordinator {
        return BaseFlowCoordinator(navigationController: navigationController, component: self, nextRouteHandler: nextRouteHandler)
    }
    
    var firstComponent: FirstCompoment {
        return FirstCompoment(parent: self)
    }
    
    var secondComponent: SecondComponent {
        return SecondComponent(parent: self)
    }
    
    var productPageFlowComponent: ProductPageFlowComponent {
        return ProductPageFlowComponent(parent: self)
    }
    
    var cartComponent: CartComponent {
        return CartComponent(parent: self)
    }
}
