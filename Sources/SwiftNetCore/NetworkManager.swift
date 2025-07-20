//
//  NetworkManager.swift
//  SwiftNetCore
//
//  Created by Sajid Shanta on 20/7/25.
//

import Foundation

public final class NetworkManager {
    private let baseURL: String
    private let urlSession: URLSession

    public init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = session
    }

    public func send<T: Decodable>(_ request: RequestProtocol, responseModel: T.Type) async throws -> T {
        guard var urlComponents = URLComponents(string: baseURL + request.path) else {
            throw NetworkError.invalidURL
        }

        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.requestFailed((response as? HTTPURLResponse)?.statusCode ?? -1)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
