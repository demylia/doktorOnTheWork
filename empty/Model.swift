//
//  Model.swift
//  empty
//
//  Created by Dmitry.Tihonov on 11.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import Foundation
import JASON

enum Logger: String {
    case error, release, warning
    
    static func log(type: Logger, className: String){
        
        print("Log: \(type.rawValue) class: \(className)")
    }
}

protocol Loadable: JSONParserProtocol {
    
    func loadData(date: String, callBack: @escaping (State) -> ())
}

protocol JSONParserProtocol {
    
    func parse(response: DNData, callBack: (State) -> ())
}

extension Loadable {
    
    func loadData(date: String, callBack: @escaping (State) -> ()){
        
        API.shared.performRequest(Router.base(endDate: date)) { json in
            
            guard let json = json
                else {
                    callBack(.error)
                    return
            }
            let response = DNData(json: json)
            self.parse(response: response, callBack: callBack)
        }
    }
}


