//
//  Publisher+Future.swift
//
//  Created by Stas Kirichok on 08.06.2021.
//

import Combine

extension Publisher {
    /// Cast any publisher as Future with the same types
    /// Can be used when future is followed by operator to keep Future semantics
    public func asFuture() -> Future<Output, Failure> {
        return Future { promise in
            var ticket: AnyCancellable?
            ticket = sink(
                receiveCompletion: {
                    ticket?.cancel()
                    ticket = nil
                    switch $0 {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                },
                receiveValue: {
                    ticket?.cancel()
                    ticket = nil
                    promise(.success($0))
                })
        }
    }
}
