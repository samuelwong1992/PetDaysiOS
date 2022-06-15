//
//  APIRequest.swift
//  PetDays
//
//  Created by Samuel Wong on 2/6/2022.
//

import Foundation
import Alamofire

typealias Parameters = [String:String]

protocol APIRequest {
    var endpoint: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension APIRequest {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}

struct APIRequestBuilder {
    static func buildRequestFromAPIRequest(request: APIRequest) throws -> URLRequest {
        let endpoint = APIManager.current.baseURL + request.endpoint
        
        print(endpoint)

        var urlRequest = URLRequest(url: URL(string: endpoint)!)
        urlRequest.httpMethod = request.method.rawValue
        if let accessToken = SessionManager.currentUser?.apiToken {
            urlRequest.addValue("Token \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        do {
            return try request.encoding.encode(urlRequest, with: request.parameters)
        } catch {
            throw NSError.standardErrorWithString(errorString: "URL couldn't be encoded for these objects.")
        }
    }
}
