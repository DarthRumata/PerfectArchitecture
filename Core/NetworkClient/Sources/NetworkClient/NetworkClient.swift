//
//  NetworkClient.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 03.12.2021.
//

import Alamofire
import Combine

public class NetworkClient {
    private let decoder = JSONDecoder()
    
    private lazy var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        
        return Session(configuration: configuration)
    }()
    
    
    // MARK: - Initialization
    
    public init() { }
    
    
    // MARK: - APISessionProvider
    
    public func execute<Request>(_ request: Request) -> DataResponsePublisher<Request.ResponseType> where Request: RequestProtocol {
        return session.request(request)
            .validate()
            .publishDecodable(type: Request.ResponseType.self, decoder: decoder)
    }
    
    public func execute<Request>(_ request: Request) -> AnyPublisher<Request.ResponseType, AFError> where Request: RequestProtocol {
        return execute(request)
            .value()
            .eraseToAnyPublisher()
    }
}
