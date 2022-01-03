//
//  Request.swift
//  WLNetworkClient
//
//  Created by Stanislav Kirichok on 29.12.2021.
//

import Foundation
import Alamofire
import SwiftyBeaver

public protocol RequestParameters: Encodable { }

public protocol RequestProtocol: URLRequestConvertible {
    associatedtype RequestParametersType: RequestParameters
    associatedtype ResponseType: Decodable
    
    // base url can be provided on request or networking session layer.
    // if baseURL may be set to nil on request level, but in this case it must be set on session level.
    var baseURL: String? { get }
    
    var path: String { get }
    var responseType: ResponseType.Type { get }
    var method: HTTPMethod { get }
    var parameters: RequestParametersType? { get }
    var encoding: ParameterEncoder { get }
}

public extension RequestProtocol {
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoder {
        /// use JSONParameterEncoder for encoding params to body
        return URLEncodedFormParameterEncoder.default
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = self.baseURL else {
            fatalError("baseUrl is nil when converting RequestProvider to URLRequest")
        }
        
        let url = try baseURL.asURL().appendingPathComponent(path)
        SwiftyBeaver.info(url.absoluteString)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            return try encoding.encode(parameters, into: urlRequest)
        } else {
            return urlRequest
        }
    }
}
