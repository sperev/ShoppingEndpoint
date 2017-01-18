//
//  Request.swift
//  ShoppingRequest
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import Foundation

public class Request {
    public init() { }
    
    public func send(_ request: URLRequest,
                     queue: OperationQueue = OperationQueue.main,
                     completion: @escaping (_ object: Any?, _ error: Error?, _ status: Int) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: queue)
        
        
        let task = session.dataTask(with: request) { data, response, error in
            var object: Any? = nil
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            }
            
            var statusCode = 0
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            queue.addOperation {
                completion(object, error, statusCode)
            }
        }
        
        task.resume()
    }
}
