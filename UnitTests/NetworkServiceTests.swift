//
//  NetworkServiceTests.swift
//  ShoppingEndpoint
//
//  Created by Sergei Perevoznikov on 13/01/2017.
//  Copyright © 2017 Sergei Perevoznikov. All rights reserved.
//

import XCTest
import Random
import ShoppingEndpoint
import Alamofire

enum JSONPlaceholder: Endpoint {
    case objects
    var path: String {
        return "posts"
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
}

class Authorization: NetworkAuthorization {
    var headers: [String : String]? = [:]
}

class NetworkServiceTests: XCTestCase {
    let url: URL = URL(string: "https://jsonplaceholder.typicode.com")!
    let authorization = Authorization()
    func testListsObjects() {
        let expect = expectation(description: "")
        let networkService = NetworkService(baseUrl: url, authorization: authorization)
        networkService.request(JSONPlaceholder.objects, parameters: nil) { object, error in
            expect.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
