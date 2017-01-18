//
//  NetworkAuthorization.swift
//  ShoppingEndpoint
//
//  Created by Sergei Perevoznikov on 18/01/2017.
//
//

public protocol NetworkAuthorization {
    var headers: [String: String]? { get }
}
