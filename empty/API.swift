//
//  API.swift
//  empty
//
//  Created by Dmitry.Tihonov on 11.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import Foundation
import Alamofire
import JASON

struct API {
    
    static let shared = API()
    
    static let dnDefaultsHeaders = ["Token" : "2e2d5102-dad4-4029-ac87-a70d00ca1966"]
    
    static let Manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration
            .background(withIdentifier: "com.example.app.background")

        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        dnDefaultsHeaders.forEach({
            defaultHeaders[$0.0] = $0.1
        })
        configuration.httpAdditionalHeaders = defaultHeaders

        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpShouldSetCookies = true

        configuration.timeoutIntervalForRequest = 18
        let sesionDelegate = SessionDelegate()
        let manager = Alamofire.SessionManager(configuration: configuration, delegate: sesionDelegate, serverTrustPolicyManager: nil)

        return manager
    }()
    
    
    func performRequest(_ request: URLRequestConvertible, handler:@escaping (JSON?) -> ()){
        
        API.Manager.request(request).responseJASON { response in
            
            //TODO: check the failure error here
            //if data.result.error == .
            let result = response.result.value
            
            handler(result)
        }
    }
    
    
    
}

