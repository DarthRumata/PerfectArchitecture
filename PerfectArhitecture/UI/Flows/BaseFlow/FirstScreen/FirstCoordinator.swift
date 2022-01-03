//
//  FirstCoordinator.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 02.12.2021.
//

import Foundation
import NeedleFoundation
import XCoordinator
import CommonLogic
import SwiftyBeaver


enum FirstFlowRoute: Route {
    case navigateToSecond
    case dismissChildFlow
}

class FirstCoordinator: ViewCoordinator<FirstFlowRoute> {
    private let container: FirstCompoment
    private let nextRouteHandler: (FirstFlowRoute) -> Void
    
    init(component: FirstCompoment, nextRouteHandler: @escaping (FirstFlowRoute) -> Void) {
        self.container = component
        self.nextRouteHandler = nextRouteHandler
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! FirstViewController
        
        super.init(rootViewController: viewController)
        
        viewController.viewModel = container.viewModel(router: weakRouter)
        SwiftyBeaver.debug("")
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }
    
    override func prepareTransition(for route: FirstFlowRoute) -> ViewTransition {
        nextRouteHandler(route)
        
        return .none()
    }
}
