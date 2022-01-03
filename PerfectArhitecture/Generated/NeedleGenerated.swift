

import Cart
import CommonLogic
import Foundation
import NeedleFoundation
import ProductPage
import SwiftyBeaver
import WLNetworkClient
import XCoordinator

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = "eaa04e586119bcc51f9fb1c09007c905"

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent->BaseFlowComponent->ProductPageFlowComponent->ProductListComponent") { component in
        return ProductListDependenciesd99f9bcd68d033458bebProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent->BaseFlowComponent->ProductPageFlowComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent->BaseFlowComponent->CartComponent") { component in
        return CartDependency37e52e595d92746b6a8aProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent->BaseFlowComponent->FirstCompoment") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent->BaseFlowComponent->SecondComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->BaseServicesComponent->BaseFlowComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

private class ProductListDependenciesd99f9bcd68d033458bebBaseProvider: ProductListDependencies {
    var productsRepository: ProductsRepository {
        return baseServicesComponent.productsRepository
    }
    private let baseServicesComponent: BaseServicesComponent
    init(baseServicesComponent: BaseServicesComponent) {
        self.baseServicesComponent = baseServicesComponent
    }
}
/// ^->RootComponent->BaseServicesComponent->BaseFlowComponent->ProductPageFlowComponent->ProductListComponent
private class ProductListDependenciesd99f9bcd68d033458bebProvider: ProductListDependenciesd99f9bcd68d033458bebBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(baseServicesComponent: component.parent.parent.parent as! BaseServicesComponent)
    }
}
private class CartDependency37e52e595d92746b6a8aBaseProvider: CartDependency {
    var productsRepository: ProductsRepository {
        return baseServicesComponent.productsRepository
    }
    private let baseServicesComponent: BaseServicesComponent
    init(baseServicesComponent: BaseServicesComponent) {
        self.baseServicesComponent = baseServicesComponent
    }
}
/// ^->RootComponent->BaseServicesComponent->BaseFlowComponent->CartComponent
private class CartDependency37e52e595d92746b6a8aProvider: CartDependency37e52e595d92746b6a8aBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(baseServicesComponent: component.parent.parent as! BaseServicesComponent)
    }
}
