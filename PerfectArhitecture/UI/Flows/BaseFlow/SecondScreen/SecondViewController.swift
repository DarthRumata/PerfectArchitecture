//
//  SecondViewController.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 01.12.2021.
//

import Foundation
import UIKit
import NeedleFoundation
import CommonUI
import Combine

class SecondViewController: BaseController {
    var domainModel: SecondDomainModel!
    
    @IBOutlet private weak var productPageButton: UIButton!
    private var cancellableBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureBindings()
    }
}

private extension SecondViewController {
    func configureViews() {
        let barItem = UIBarButtonItem()
        barItem.style = .plain
        barItem.title = "Cart"
        navigationItem.rightBarButtonItem = barItem
    }
    
    func configureBindings() {
        navigationItem.leftBarButtonItem?.tapPublisher
            .publish(to: domainModel.onTapBackButton)
            .store(in: &cancellableBag)
        navigationItem.rightBarButtonItem?.tapPublisher
            .publish(to: domainModel.onTapCartButton)
            .store(in: &cancellableBag)
        productPageButton.tapPublisher()
            .publish(to: domainModel.onTapProductPageButton)
            .store(in: &cancellableBag)
    }
}


