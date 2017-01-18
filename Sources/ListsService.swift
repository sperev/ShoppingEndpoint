//
//  ListsEndpoint.swift
//  ShoppingEndpoint
//
//  Created by Sergei Perevoznikov on 18/01/2017.
//
//

import ShoppingModels
import Alamofire

enum ListsEndpoint: Endpoint {
    case objects
    case add
    case rename
    case delete
    
    var path: String {
        return "lists"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .objects: return .get
        case .add: return .post
        case .rename: return .put
        case .delete: return .delete
        }
    }
}

typealias ListsCompletion = ([ListProtocol]?, Error?) -> Void

protocol ListsService {
    func objects(completion: ListsCompletion)
    func rename(id: String, completion: NetworkErrorCompletion)
    func remove(id: String, completion: NetworkErrorCompletion)
    func add(id: String, name: String, completion: NetworkErrorCompletion)
}

final class ListsServiceProvider: ListsService {
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func objects(completion: ListsCompletion) {
        networkService.request(ListsEndpoint.objects, parameters: nil, completion: nil)
    }
    
    func rename(id: String, completion: NetworkErrorCompletion) {
        let parameters = [ "id": id ]
        networkService.request(ListsEndpoint.rename, parameters: parameters, completion: nil)
    }
    
    func remove(id: String, completion: NetworkErrorCompletion) {
        let parameters = [ "id": id ]
        networkService.request(ListsEndpoint.delete, parameters: parameters, completion: nil)
    }
    
    func add(id: String, name: String, completion: NetworkErrorCompletion) {
        let parameters = [
            "id": id,
            "name" : name
        ]
        networkService.request(ListsEndpoint.add, parameters: parameters, completion: nil)
    }
}
