//
//  RootComponent.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 07.12.2021.
//

import Foundation
import NeedleFoundation
import CommonLogic
import ProductPage
import Cart
import WLNetworkClient

class RootComponent: BootstrapComponent {
    var baseServicesComponent: BaseServicesComponent {
        return BaseServicesComponent(parent: self)
    }
}

class BaseServicesComponent: Component<EmptyDependency> {
    var appModel: AppModel {
        return shared { AppModel() }
    }
    
    var networkClient: NetworkClient {
        return shared { NetworkClient() }
    }
    
    var productsRepository: ProductsRepository {
        let networkService = ProductsNetworkService(networkClient: networkClient)
        return shared { ProductsRepository(networkService: networkService) }
    }
    
    func appCoordinator(window: UIWindow) -> AppCoordinator {
        return AppCoordinator(component: self, window: window)
    }
    
    var baseFlowComponent: BaseFlowComponent {
        return BaseFlowComponent(parent: self)
    }
}
