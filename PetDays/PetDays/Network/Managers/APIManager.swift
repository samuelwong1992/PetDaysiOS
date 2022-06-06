//
//  APIManager.swift
//  PetDays
//
//  Created by Samuel Wong on 2/6/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

private var _apiManager: APIManager!

class APIManager {
    var baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    static var current: APIManager {
        if let apiManager = _apiManager {
            return apiManager
        }
        
        let path = "http://127.0.0.1:8000"
        
        _apiManager = APIManager(baseURL: path)
        return _apiManager
    }
    
    func performRequest(request: APIRequest, shouldShowLoading: Bool = true, completion: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        if shouldShowLoading {
//            LoadingHUD.show()
        }
        defer {
            if shouldShowLoading {
    //            LoadingHUD.dismiss()
            }
        }
        
        if String.isNilOrEmpty(request.endpoint) {
            return completion(nil, NSError.standardErrorWithString(errorString: "Could not find a URL for this object."))
        }

        do {
            let urlRequest = try APIRequestBuilder.buildRequestFromAPIRequest(request: request)
            
            AF.request(urlRequest)
                .validate()
                .responseJSON { jsonResponse in
                    switch jsonResponse.result {
                    case .success:
                        var json:JSON!
                        
                        if jsonResponse.response == nil {
                            return completion(nil, NSError.standardErrorWithString(errorString: APIResponse.StatusCode._204_NO_CONTENT.description))
                        }
                        
                        if let data = jsonResponse.value {
                            json = JSON(data)
                        }
                        
                        let code = jsonResponse.response!.statusCode
                        
                        if let statusCode = APIResponse.StatusCode(rawValue: code) {
                            switch statusCode {
                            case ._200_SUCCESS, ._201_CREATED, ._202_ACCEPTED, ._204_NO_CONTENT :
                                return completion(json ?? JSON(["success" : statusCode.code]), nil)
                                
                            case ._401_UNAUTHORIZED :
                                return completion(nil, NSError.standardErrorWithString(errorString: APIResponse.StatusCode._401_UNAUTHORIZED.description))
                                
                            case ._404_NOT_FOUND :
                                return completion(nil, NSError.standardErrorWithString(errorString: APIResponse.StatusCode._404_NOT_FOUND.description))
                                
                            default :
                                var errorString: String = ""
                                if let errorJSON = json[APIResponse.API_JSON_DEFINED_ERROR].string {
                                    if errorJSON != "" {
                                        errorString = errorJSON
                                    }
                                } else {
                                    errorString = statusCode.description
                                }
                                
                                return completion(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: statusCode.code, userInfo: [NSLocalizedDescriptionKey : errorString]))
                            }
                        } else {
                            //Unhandled Return Code
                            if code < 200 || code >= 300 {
                                return completion(nil, NSError.standardErrorWithString(errorString: "The server responded with an unknown error.\nError Code \(code)"))
                            }
                        }
                        
                        //Final catch if the server responds success with an error in JSON
                        if let errorJSON = json[APIResponse.API_JSON_DEFINED_ERROR].string {
                            if errorJSON != "" {
                                return completion(nil, NSError.standardErrorWithString(errorString: errorJSON))
                            }
                        }
                        
                        return completion(json!,nil)
                        
                    case let .failure(error):
                        print(error)
                        if let response = jsonResponse.response {
                            if let statusCode = APIResponse.StatusCode(rawValue: response.statusCode) {
                                switch statusCode {
                                case ._401_UNAUTHORIZED :
                                    return completion(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: APIResponse.StatusCode._401_UNAUTHORIZED.code, userInfo: [NSLocalizedDescriptionKey : APIResponse.StatusCode._401_UNAUTHORIZED.description]))

                                case ._404_NOT_FOUND :
                                    return completion(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: statusCode.code, userInfo: [NSLocalizedDescriptionKey : APIResponse.StatusCode._404_NOT_FOUND.description]))
                                    
                                default :
                                    if let data = jsonResponse.value {
                                        let json = JSON(data)
                                        if let errorJSON = json[APIResponse.API_JSON_DEFINED_ERROR].string {
                                            if errorJSON != "" {
                                                return completion(nil, NSError.standardErrorWithString(errorString: errorJSON))
                                            }
                                        }
                                    }
                                    
                                    return completion(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: [NSLocalizedDescriptionKey : error.localizedDescription]))
                                    }
                                }
                        } else {
                            return completion(nil, NSError.standardErrorWithString(errorString: error.localizedDescription))
                        }
                    }
            }
        } catch {
            return completion(nil, NSError.standardErrorWithString(errorString: "URL couldn't be encoded for these objects."))
        }
    }
}
