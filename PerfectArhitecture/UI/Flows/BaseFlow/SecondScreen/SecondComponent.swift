//
//  SecondComponent.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 07.12.2021.
//

import Foundation
import NeedleFoundation
import CommonLogic
import XCoordinator

class SecondService {
    deinit {
        print("SecondService deinit")
    }
}

class SecondComponent: Component<EmptyDependency> {
    func domainModel(router: WeakRouter<SecondFlowRoute>) -> SecondDomainModel {
        return SecondDomainModel(secondService: secondService, router: router)
    }
    
    var secondService: SecondService {
        return shared { SecondService() }
    }
    
    func coordinator(nextRouteHandler: @escaping (SecondFlowRoute) -> Void) -> SecondCoordinator {
        return SecondCoordinator(component: self, nextHandlerCallback: nextRouteHandler)
    }
    
    deinit {
        print("SecondComponent deinit")
    }
}
