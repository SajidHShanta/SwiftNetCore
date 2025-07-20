//
//  RequestProtocol.swift
//  SwiftNetCore
//
//  Created by Sajid Shanta on 20/7/25.
//

import Foundation

public protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
}
