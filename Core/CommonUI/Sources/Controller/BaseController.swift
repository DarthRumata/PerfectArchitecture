//
//  File.swift
//  CommonUI
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import UIKit

public enum NavigationBarDismissFlowMode {
    case backButton
    case closeButton
    case none
}

open class BaseController: UIViewController {
    open var navigationBarDismissMode: NavigationBarDismissFlowMode {
        return .backButton
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDismissMode()
    }
    
    private func configureBackButton() {
        let button = UIBarButtonItem()
        let image = UIImage(systemName: "arrow.backward")
        button.image = image
        button.style = .plain
        navigationItem.leftBarButtonItem = button
    }
    
    private func configureCloseButton() {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "xmark")
        button.style = .plain
        navigationItem.leftBarButtonItem = button
    }
    
    private func configureDismissMode() {
        switch navigationBarDismissMode {
        case .backButton:
            configureBackButton()
        case .closeButton:
            configureCloseButton()
        case .none:
            navigationItem.leftBarButtonItem = nil
        }
    }
}
