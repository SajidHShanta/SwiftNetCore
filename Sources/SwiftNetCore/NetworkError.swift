//
//  NetworkError.swift
//  SwiftNetCore
//
//  Created by Sajid Shanta on 20/7/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case requestFailed(Int)
    case decodingFailed
    case unknown(Error)
}
