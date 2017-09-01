//
//  Data.swift
//  empty
//
//  Created by Dmitry.Tihonov on 11.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import Foundation
import JASON

protocol JSONInitializable {
    
    init(json: JSON)
}

protocol Textable {
    
    var title: String { get }
    var annotation: String { get }
    var createdAt: String { get }
    var createdAtDate: String { get }
    var author: Author { get }
    var videos:[Content] { get }
    var photos:[Content] { get }
    var countOfSection: Int { get }
}

enum State: Int {
    
    case ok = 0
    case error = -1
    case redirect = 1
    case refresh = 2
}

enum ErrorCode: Int {
    
    case tokenNotFound = 6
}



struct DNResponse: JSONInitializable {
    
    var state: State
    var data: JSON
    
    init(json: JSON) {
        self.state = State(rawValue:json["state"].intValue) ?? State.error
        self.data = json["data"].json
    }
}

struct DNData {
    
    var hasMore: Bool
    var publications: [Publication]
    var errorMessage: String?
    var state: Bool
    
    init(json: JSON) {
        
        publications = json["publications"].jsonArray?.flatMap({ Publication(json: $0.json) }) ?? []
        errorMessage = json["errorMessage"].string
        state = json["ok"].boolValue
        hasMore = json["hasMore"].boolValue
    }
}

struct Publication: Textable {
    
    var id: Int
    var title: String
    var createdAt: String
    var createdAtDate: String
    
    var annotation: String
    var hasFullContent: Bool
    var author: Author
    var videos:[Content]
    var photos:[Content]
    
    init(json: JSON) {
        
        id = json["id"].intValue
        title = json["title"].stringValue
        createdAt = json["createdAt"].stringValue
        createdAtDate = createdAt.components(separatedBy: "T").first ?? ""
        annotation = json["annotation"].stringValue
        hasFullContent = json["hasFullContent"].boolValue
        author = Author(json: json["author"].json)
        videos = json["videos"].jsonArray?.flatMap({ Content(json: $0.json) }) ?? []
        photos = json["photos"].jsonArray?.flatMap({ Content(json: $0.json) }) ?? []
    }
    
    var countOfSection: Int {
        
        var count = 1
        if videos.count > 0 {
            count += 1
        }
        if photos.count > 0 {
            count += 1
        }
        return count
    }
    

}
enum Sex: Int {
    case male = 0,female
}
struct Author {
    
    var id: Int
    var avatar: String
    var shortName: String
    var degree: String
    var specialty: String
    var sex: Sex
    var firstName: String
    var middleName: String
    var lastName: String

    
    init(json: JSON){
        
        id = json["id"].intValue
        avatar = json["avatar"].stringValue
        shortName = json["shortName"].stringValue
        degree = json["degree"].stringValue
        specialty = json["specialty"].stringValue
        sex = Sex(rawValue: json["sex"].intValue) ?? Sex.female
        firstName = json["firstName"].stringValue
        middleName = json["middleName"].stringValue
        lastName = json["lastName"].stringValue
    }
    
    var avatarUrl: URL? {
        return URL(string: avatar)
    }
}

struct Content {
    
    var url: URL?
    var previewUrl: URL?
    var title: String
    
    init(json: JSON) {
        
        url = URL(string:json["url"].stringValue)
        previewUrl = URL(string:json["previewUrl"].stringValue)
        title = json["title"].stringValue
    }
    
    var videoId: String {
        return url?.absoluteString.components(separatedBy: "v=").last ?? ""
    }
}




