//
//  SecondViewController.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 01.12.2021.
//

import Foundation
import UIKit
import CommonUI
import Combine

class CartViewController: BaseController {
    var domainModel: CartDomainModel!
    
    private var cancellableBag = Set<AnyCancellable>()
    
    override var navigationBarDismissMode: NavigationBarDismissFlowMode {
        return .closeButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBindings()
    }
}

private extension CartViewController {
    func configureBindings() {
        navigationItem.leftBarButtonItem?.tapPublisher
            .publish(to: domainModel.onTapCloseButton)
            .store(in: &cancellableBag)
    }
}
