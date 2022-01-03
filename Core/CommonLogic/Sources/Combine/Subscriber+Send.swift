//
//  Subscriber+TypeErasure.swift
//
//  Created by Stas Kirichok on 06.06.2021.
//

import Combine

public extension Subscriber where Self.Input == Void {
    func send() {
        _ = receive(())
    }
}

public extension Subscriber {
    func send(_ input: Input) {
        _ = receive(input)
    }
}
