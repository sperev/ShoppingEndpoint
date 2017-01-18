//
//  ListsEndpoint.swift
//  ShoppingEndpoint
//
//  Created by Sergei Perevoznikov on 18/01/2017.
//
//

import ShoppingModels

typealias ListsCompletion = ([ListProtocol]?, Error?) -> Void

protocol ListsEndpoint: Endpoint {
    func objects(completion: ListsCompletion)
    func rename(id: String, completion: NetworkErrorCompletion)
    func remove(id: String, completion: NetworkErrorCompletion)
    func add(id: String, name: String, completion: NetworkErrorCompletion)
}

final class ListsService: ListsEndpoint {
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func objects(completion: ListsCompletion) {
        
    }
    
    func rename(id: String, completion: NetworkErrorCompletion) {
        
    }
    
    func remove(id: String, completion: NetworkErrorCompletion) {
        
    }
    
    func add(id: String, name: String, completion: NetworkErrorCompletion) {
        
    }
    
}
