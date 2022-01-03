//
//  UIControl+Combine.swift
//
//  Created by Stas Kirichok on 30.04.2021.
//

import Combine
import UIKit

public extension UIControl {
    /// A publisher which emits event whenever this UIButton is tapped.
    func tapPublisher(for event: UIControl.Event = .touchUpInside) -> AnyPublisher<Void, Never> {
        return Publishers.ControlTarget(
            control: self,
            addTargetAction: { control, target, action in
                control.addTarget(target, action: action, for: event)
            },
            removeTargetAction: { control, target, action in
                control?.removeTarget(target, action: action, for: event)
            }
        )
        .eraseToAnyPublisher()
    }
}
