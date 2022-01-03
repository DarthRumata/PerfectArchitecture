//
//  SecondCoordinator.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 02.12.2021.
//

import Foundation
import NeedleFoundation
import XCoordinator
import CommonLogic
import ProductPage
import Cart
import SwiftyBeaver

enum SecondFlowRoute: Route {
    case openProductPage
    case openCart
    
    case flowFinished
}

final class SecondCoordinator: ViewCoordinator<SecondFlowRoute> {
    private let component: SecondComponent
    private let nextHandlerCallback: (SecondFlowRoute) -> Void
    
    init(component: SecondComponent, nextHandlerCallback: @escaping (SecondFlowRoute) -> Void) {
        self.component = component
        self.nextHandlerCallback = nextHandlerCallback
        
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! SecondViewController
        
        super.init(rootViewController: viewController)
        
        viewController.domainModel = component.domainModel(router: weakRouter)
        SwiftyBeaver.debug("")
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }
    
    override func prepareTransition(for route: SecondFlowRoute) -> ViewTransition {
        nextHandlerCallback(route)
        
        return .none()
    }
}
