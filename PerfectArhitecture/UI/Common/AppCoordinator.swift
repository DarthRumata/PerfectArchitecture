//
//  AppCoordinator.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 07.12.2021.
//

import XCoordinator
import SwiftyBeaver

enum AppRoute: Route {
    case baseFlow
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    private let component: BaseServicesComponent
    
    init(component: BaseServicesComponent, window: UIWindow) {
        self.component = component
        
        super.init(rootViewController: UINavigationController())
        
        setRoot(for: window)
        
        component.appModel.configure()
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .baseFlow:
            let coordinator = component.baseFlowComponent.coordinator(navigationController: rootViewController) { [weak self] route in
                switch route {
                default:
                    break
                }
            }
            addChild(coordinator)
            return .trigger(.firstScreen, on: coordinator)
        }
    }
}
