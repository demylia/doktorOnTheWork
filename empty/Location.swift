//
//  Location.swift
//  empty
//
//  Created by Dmitry.Tihonov on 11.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import Foundation
import UIKit

enum Location: String{
    
    case ru,by,kz,kg, com
    
    static let all = [Location.ru,.by,.kz,.kg,.com]
    
    var name: String {
        
        switch self {
        case .ru: return "РОССИЯ"
        case .by: return "БЕЛАРУСЬ"
        case .kz: return "КАЗАХСТАН"
        case .kg: return "КИРГИЗИЯ"
        case .com: return "USA"
        }
    }
    
    var phoneCode: String {
        switch self {
        case .ru, .kz: return "+7"
        case .by: return "+375"
        case .kg: return "+996"
        case .com: return "+1"
        }
    }
    
    var flagImage: UIImage? {
        let name: String
        switch self {
        case .ru: name = "flag_ru"
        case .by: name = "flag_by"
        case .kz: name = "flag_kz"
        case .kg: name = "flag_kg"
        case .com: name = "flag_com"
        }
        return UIImage(named: name)
    }
    
    var phoneExample: String {
        switch self {
        case .ru,.kz: return "Например, +79150550426"
        case .by: return "Например, +375292549155"
        case .kg: return "Например, +996512549155"
        case .com: return "Например, +12323420943"
        }
    }
    
    var phoneNumbersCount: Int {
        return self == Location.by || self == Location.kg  ? 13 : 12
    }
}

func locationWithCode(code:Int) -> Location {
    switch code {
    case 7:
        return .kz
    case 375:
        return .by
    case 996:
        return .kg
    default:
        return .com
    }
}

extension Location: Equatable {}

func ==(lhs: Location, rhs: Location) -> Bool {
    return lhs.name == rhs.name
}
