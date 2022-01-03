//
//  SecondCoordinator.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 02.12.2021.
//

import Foundation
import XCoordinator
import SwiftyBeaver

public enum CartRoute: Route {
    case flowFinished
}

public final class CartCoordinator: ViewCoordinator<CartRoute> {
    private let container: CartComponent
    private let nextHandlerCallback: (CartRoute) -> Void
    
    
    
    init(component: CartComponent, nextHandlerCallback: @escaping (CartRoute) -> Void) {
        container = component
        self.nextHandlerCallback = nextHandlerCallback
        
        let storyboard = UIStoryboard(name: "Cart", bundle: Bundle.init(for: type(of: self)))
        let viewController = storyboard.instantiateInitialViewController() as! CartViewController
        let navigation = UINavigationController(rootViewController: viewController)
        
        super.init(rootViewController: navigation)
        
        viewController.domainModel = container.domainModel(router: weakRouter)
        SwiftyBeaver.debug("init")
    }
    
    deinit {
        SwiftyBeaver.debug("deinit")
    }
    
    public override func prepareTransition(for route: CartRoute) -> ViewTransition {
        nextHandlerCallback(route)
        
        return .none()
    }
}
