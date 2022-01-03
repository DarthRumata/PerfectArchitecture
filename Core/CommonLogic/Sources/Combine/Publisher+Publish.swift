//
//  SignalPublisher.swift
//
//  Created by Stas Kirichok on 29.04.2021.
//

import Combine

public extension Publisher {
    /// Should be used instead of system subscribe for correct memory management for MergeSink
    func publish<S>(to subscriber: S) -> AnyCancellable where S: Subscriber & Cancellable, S.Input == Self.Output, Self.Failure == S.Failure {

        subscribe(subscriber)
        return AnyCancellable(subscriber)
    }
}

public extension Publisher where Self.Failure == Never {
    func publish(to subject: CurrentValueSubject<Output, Failure>) -> AnyCancellable {
        return sink { value in
            subject.send(value)
        }
    }

    func publish(to subject: PassthroughSubject<Output, Failure>) -> AnyCancellable {
        return sink { value in
            subject.send(value)
        }
    }
}
