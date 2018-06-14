//
//  Router.swift
//  empty
//
//  Created by Dmitry.Tihonov on 11.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    
    private enum APIType {
        case production(domain: String)
        case development(domain: String)
    }
    
    private static var domain: String {
        return Location.ru.rawValue
    }
    
    private static var API: APIType {
        return .development(domain: Router.domain)
    }
    
    struct ConstantBaseUrls {
        static let Production = "https://api.doktornarabote."
        static let Development = "http://testapi.doktornarabote."
    }
    
    static var baseURLString: String  {
        switch Router.API {
        case .production(let domain):
            return ConstantBaseUrls.Production + domain
        case .development(let domain):
            return ConstantBaseUrls.Development + domain
        }
    }
    
    static let baseURL = NSURL(string: Router.baseURLString)
    
    case base(endDate: String)
    
    case other

}

extension Router: URLRequestConvertible {
    
    var path: String {
        
        switch self {
        case .base(let endDate):
            return "/api/v5/publications?take=10&endDate=" + endDate
        default:
            return Router.baseURLString
        }
    }
    var urlString: String {
        
        switch self {
        case .base:
            return Router.baseURLString + path
        default:
            return Router.baseURLString
        }
    }
    
    var params: [String: AnyObject]? {
        
        return nil
    }
    
    var method: String {
        switch self {
        case .base:
            return HTTPMethod.get.rawValue
        default:
            return HTTPMethod.post.rawValue
        }
    }
    
    func asURLRequest() throws -> URLRequest {
    
        let url = try urlString.asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        if let url = urlRequest.url?.absoluteString {
            print(url)
        }
        return urlRequest
    }
}
