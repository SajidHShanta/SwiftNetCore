//
//  MultipartFormData.swift
//  SwiftNetCore
//
//  Created by Sajid Shanta on 20/7/25.
//

import Foundation

public struct MultipartFormData {
    private let boundary: String
    private var body = Data()

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
    }

    public mutating func addField(name: String, value: String) {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
    }

    public mutating func addFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data) {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.appendString("\r\n")
    }

    public mutating func finalize() {
        body.appendString("--\(boundary)--\r\n")
    }

    public func getContentType() -> String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public func getBody() -> Data {
        body
    }
}

private extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
