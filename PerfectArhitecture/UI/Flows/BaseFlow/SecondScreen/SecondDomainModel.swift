//
//  SecondDomainModel.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import CommonLogic
import XCoordinator
import Combine
import SwiftyBeaver

class SecondDomainModel {
    // MARK: Input
    private(set) lazy var onTapCartButton = Subscribers.MergeSink<Void> { [weak self] _ in
        self?.router.trigger(.openCart)
    }
    private(set) lazy var onTapProductPageButton = Subscribers.MergeSink<Void> { [weak self] _ in
        self?.router.trigger(.openProductPage)
    }
    private(set) lazy var onTapBackButton = Subscribers.MergeSink<Void> { [weak self] _ in
        self?.router.trigger(.flowFinished)
    }
    
    // MARK: Dependencies
    private let router: WeakRouter<SecondFlowRoute>
    private let secondService: SecondService
    
    init(secondService: SecondService, router: WeakRouter<SecondFlowRoute>) {
        self.router = router
        self.secondService = secondService
        SwiftyBeaver.debug("")
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }

}
