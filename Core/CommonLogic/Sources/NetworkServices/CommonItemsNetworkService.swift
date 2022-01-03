//
//  CommonItemsNetworkService.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 03.12.2021.
//

import Foundation
import WLNetworkClient
import SwiftyBeaver
import Combine
import Alamofire

extension String: RequestParameters {
    
}

struct GetProductsRequest: RequestProtocol {
    let baseURL: String? = "https://api.sampleapis.com"
    
    let path = "/wines/reds"
    let parameters: String? = nil
    let responseType = [ProductDTO].self
}

public class ProductsNetworkService {
    private let networkClient: NetworkClient
    
    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        
        SwiftyBeaver.debug("")
    }
    
    public func getProducts() -> Future<[Product], AFError> {
        networkClient.execute(GetProductsRequest())
            .map { $0.map { $0.makeEntity() } }
            .asFuture()
    }
    
    deinit {
        SwiftyBeaver.debug("")
    }
}
