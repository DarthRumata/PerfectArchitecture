//
//  BaseFlowCoordinator.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 07.12.2021.
//

import Foundation
import XCoordinator

enum BaseFlowRoute: Route {
    case firstScreen
    case secondScreen
    
    case popChildFlow
    case dismissChildFlow
    
    case openCart
    case openProductPage
}

class BaseFlowCoordinator: NavigationCoordinator<BaseFlowRoute> {
    private let component: BaseFlowComponent
    private let nextRouteHandler: (BaseFlowRoute) -> Void
    
    init(navigationController: UINavigationController, component: BaseFlowComponent, nextRouteHandler: @escaping (BaseFlowRoute) -> Void) {
        self.component = component
        self.nextRouteHandler = nextRouteHandler
        
        super.init(rootViewController: navigationController)
    }
    
    override func prepareTransition(for route: BaseFlowRoute) -> NavigationTransition {
        switch route {
        case .firstScreen:
            let coordinator = component.firstComponent.coordinator { [weak self] route in
                switch route {
                case .navigateToSecond:
                    self?.trigger(.secondScreen)
                    
                case .dismissChildFlow:
                    self?.trigger(.popChildFlow)
                }
            }
            return .push(coordinator)
            
        case .secondScreen:
            let coordinator = component.secondComponent.coordinator { [weak self] route in
                switch route {
                case .flowFinished:
                    self?.trigger(.popChildFlow)
                    
                case .openCart:
                    self?.trigger(.openCart)
                    
                case .openProductPage:
                    self?.trigger(.openProductPage)
                }
            }
            return .push(coordinator)
            
        case .openProductPage:
            let coordinator = component.productPageFlowComponent.coordinator(navigationController: rootViewController) { [weak self] route in
                switch route {
                case .flowFinished(let child):
                    self?.removeChild(child)
                    self?.trigger(.popChildFlow)
                    
                default:
                    break
                }
            }
            addChild(coordinator)
            return .trigger(.initial, on: coordinator)
            
        case .openCart:
            let coordinator = component.cartComponent.coordinator { [weak self] route in
                switch route {
                case .flowFinished:
                    self?.trigger(.dismissChildFlow)
                }
            }
            return .present(coordinator)
            
        case .popChildFlow:
            return .pop()
            
        case .dismissChildFlow:
            return .dismiss()
            
        default:
            nextRouteHandler(route)
            return .none()
        }
    }
}
