//
//  Future.swift
//
//  Created by Stas Kirichok on 13.05.2021.
//

import Combine

public extension Future {
    func sink(onSuccess: @escaping (Output) -> Void, onError: @escaping (Failure) -> Void) -> AnyCancellable {
        return sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    onError(error)
                }
            },
            receiveValue: onSuccess
        )
    }

    func sink(onSuccess: @escaping (Output) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { _ in }, receiveValue: onSuccess)
    }

    func sink(onError: @escaping (Failure) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                onError(error)
            }
        }, receiveValue: { _ in })
    }

    func sink(onResolved: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                onResolved(.failure(error))
            }
        }, receiveValue: { value in
            onResolved(.success(value))
        })
    }
}
