//
//  Request.swift
//  AppServices
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import Foundation

/// A protocol defining the structure of a network request.
public protocol Request {
    
    /// The path of the endpoint to be appended to the base URL.
    var path: String { get }
    
    var url: URL? { get }
    
    /// The HTTP method of the request.
    var method: HTTPMethod { get }
    
    /// The content type of the request.
    var contentType: String { get }
    
    /// The body parameters of the request.
    var body: [String: Any]? { get }
    
    /// The query parameters of the request.
    var queryParams: [String: Any]? { get }
    
    /// The headers of the request.
    var headers: [String: String]? { get }
    
    /// The type of return data from the request.
    associatedtype ReturnType: Codable
}

public extension Request {
    
    var url: URL? {
        return URL(string: NetworkConstants.basedURL + path)
    }
    
    /// Default implementation of the HTTP method, which is GET.
    var method: HTTPMethod { return .get }
    
    /// Default implementation of the content type, which is JSON.
    var contentType: String { return ContentType.json.rawValue }
    
    /// Default implementation of the query parameters, which is nil.
    var queryParams: [String: Any]? { return nil }
    
    /// Default implementation of the body parameters, which is an empty dictionary.
    var body: [String: Any]? { return nil }
    
    /// Default implementation of the headers, which is nil.
    var headers: [String: String]? {
        return [HTTPHeaderField.acceptLanguage.rawValue: "en",
                HTTPHeaderField.contentType.rawValue: "application/json",
                HTTPHeaderField.authorization.rawValue: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YWQ0M2E0MDVjNzBmYzNiNjVmYTBjNThmZTc0ZjcwMyIsInN1YiI6IjVmYTdjMDU2ZTZkM2NjMDAzZTFkYmE2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SdVFsU8eJgNvjKib3L1Li6hl_c_x-PpRWEhx__vnaL8"]
    }
}

public extension Request {
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params,
              let httpBody = try? JSONSerialization.data(withJSONObject: params) else {
            return nil
        }
        return httpBody
    }
    
    /// Transforms an Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        
        ///Set your Common Headers here
        ///Like: api secret key for authorization header
        ///Or set your content type
        //request.setValue("Your API Token key", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        request.allHTTPHeaderFields = headers
        return request
    }
}
