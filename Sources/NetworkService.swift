//
//  NetworkService.swift
//  ShoppingEndpoint
//
//  Created by Sergei Perevoznikov on 18/01/17.
//  Copyright © 2017 Shopping. All rights reserved.
//

import Alamofire
import ObjectMapper

// MARK: NetworkService Endpoint protocol
public protocol Endpoint {
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
}

public enum NetworkError: Error {
    case unknown
    case network
}

public typealias NetworkCompletion = (_ object: Any?, _ error: NetworkError?) -> Void
public typealias NetworkErrorCompletion = (_ error: NetworkError?) -> Void

public protocol NetworkServiceProtocol {
    func request(_ endpoint: Endpoint, parameters: [String: Any]?, completion: NetworkCompletion?)
}

// MARK: NetworkService
public final class NetworkService: NetworkServiceProtocol {
    let baseUrl: URL
    let authorization: NetworkAuthorization
    
    public init(baseUrl: URL, authorization: NetworkAuthorization) {
        self.baseUrl = baseUrl
        self.authorization = authorization
    }
    
    public func request(_ endpoint: Endpoint,
                 parameters: [String: Any]?,
                 completion: NetworkCompletion?) {
        let url = baseUrl.appendingPathComponent(endpoint.path)
        request(endpoint.method, url: url, parameters: parameters, completion: completion)
    }
    
    private func request(_ method: Alamofire.HTTPMethod,
                         url: URL,
                         parameters: [String: Any]?,
                         encoding: ParameterEncoding = JSONEncoding.default,
                         completion: NetworkCompletion?) {
        
        var allHeaders: [String: String] = [:]
        
        if let headers = authorization.headers {
            allHeaders = headers
        }
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: allHeaders).responseJSON { [weak self] response in
            let object = self?.json(response.data)
            let error = self?.error(response.response)
            completion?(object, error)
        }
    }
    
    private func json(_ data: Data?) -> Any? {
        guard let validData = data, validData.count != 0 else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: validData, options: .allowFragments)
    }
    
    private func error(_ response: HTTPURLResponse?) -> NetworkError? {
        return .unknown
    }
}
