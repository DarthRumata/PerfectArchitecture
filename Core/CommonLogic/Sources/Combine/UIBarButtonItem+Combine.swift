//
//  UIBarButtonItem+Combine.swift
//
//  Created by Stas Kirichok on 29.04.2021.
//

import Combine
import UIKit

public extension UIBarButtonItem {
    /// A publisher which emits whenever this UIBarButtonItem is tapped.
    var tapPublisher: AnyPublisher<Void, Never> {
        Publishers.ControlTarget(
            control: self,
            addTargetAction: { control, target, action in
                control.target = target
                control.action = action
            },
            removeTargetAction: { control, _, _ in
                control?.target = nil
                control?.action = nil
            }
        )
        .eraseToAnyPublisher()
    }
}
