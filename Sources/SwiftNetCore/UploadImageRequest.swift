//
//  UploadImageRequest.swift
//  SwiftNetCore
//
//  Created by Sajid Shanta on 20/7/25.
//

import Foundation

public struct UploadImageRequest: RequestProtocol {
    public var path: String = "/upload"
    public var method: HTTPMethod = .post
    public var headers: [String : String]
    public var body: Data?
    public var queryItems: [URLQueryItem]? = nil

    public init(imageData: Data, fileName: String, token: String? = nil) {
        var form = MultipartFormData()
        form.addFileData(fieldName: "file", fileName: fileName, mimeType: "image/jpeg", fileData: imageData)
        form.finalize()

        self.body = form.getBody()
        self.headers = [
            "Content-Type": form.getContentType()
        ]

        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
    }
}
