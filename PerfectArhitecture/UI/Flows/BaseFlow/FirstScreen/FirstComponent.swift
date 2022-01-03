//
//  FirstComponent.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 07.12.2021.
//

import Foundation
import NeedleFoundation
import CommonLogic
import XCoordinator

class FirstCompoment: Component<EmptyDependency> {
    func viewModel(router: WeakRouter<FirstFlowRoute>) -> FirstViewModel {
        return FirstViewModel(router: router)
    }
    
    func coordinator( nextRouteHandler: @escaping (FirstFlowRoute) -> Void) -> FirstCoordinator {
        return FirstCoordinator(component: self, nextRouteHandler: nextRouteHandler)
    }
}
