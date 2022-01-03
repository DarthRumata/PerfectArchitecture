//
//  GesturePublisher.swift
//
//  Created by Stas Kirichok on 17.05.2021.
//

import Combine
import UIKit

extension Combine.Publishers {
    public struct Gesture: Publisher {
        public typealias Output = GestureType
        public typealias Failure = Never
        private let view: UIView
        private let gestureType: GestureType

        public init(view: UIView, gestureType: GestureType) {
            self.view = view
            self.gestureType = gestureType
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Gesture.Failure == S.Failure, Gesture.Output == S.Input {
            let subscription = Subscription(
                subscriber: subscriber,
                view: view,
                gestureType: gestureType
            )
            subscriber.receive(subscription: subscription)
        }
    }
}

public enum GestureType {
    case tap(UITapGestureRecognizer = .init())
    case swipe(UISwipeGestureRecognizer = .init())
    case longPress(UILongPressGestureRecognizer = .init())
    case pan(UIPanGestureRecognizer = .init())
    case pinch(UIPinchGestureRecognizer = .init())
    case edge(UIScreenEdgePanGestureRecognizer = .init())

    public func get() -> UIGestureRecognizer {
        switch self {
        case let .tap(tapGesture):
            return tapGesture
        case let .swipe(swipeGesture):
            return swipeGesture
        case let .longPress(longPressGesture):
            return longPressGesture
        case let .pan(panGesture):
            return panGesture
        case let .pinch(pinchGesture):
            return pinchGesture
        case let .edge(edgePanGesture):
            return edgePanGesture
        }
    }
}

private extension Combine.Publishers.Gesture {
    private final class Subscription<S: Subscriber>: Combine.Subscription where S.Input == GestureType, S.Failure == Never {
        private var subscriber: S?
        private var gestureType: GestureType
        private var view: UIView

        init(subscriber: S, view: UIView, gestureType: GestureType) {
            self.subscriber = subscriber
            self.view = view
            self.gestureType = gestureType
            configureGesture(gestureType)
        }

        private func configureGesture(_ gestureType: GestureType) {
            let gesture = gestureType.get()
            gesture.addTarget(self, action: #selector(handler))
            view.addGestureRecognizer(gesture)
        }

        func request(_ demand: Subscribers.Demand) { }

        func cancel() {
            subscriber = nil
        }

        @objc
        private func handler() {
            _ = subscriber?.receive(gestureType)
        }
    }
}
