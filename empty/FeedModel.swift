//
//  FeedModel.swift
//  empty
//
//  Created by demylia on 29.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import Foundation
import JASON

class FeedModel: Loadable {

    var feedData: DNData?
    var countOfRows: Int {
        return feedData?.publications.count ?? 1
    }
    var publications:[Textable]{
        return feedData?.publications ?? []
    }
    
    func publicationAtIndex(_ index: Int) -> Textable? {
        
        guard index < publications.count else { return nil }
        
        return publications[index]
    }

    func parse(response: DNData, callBack: (State) -> ()) {
        
        
        if self.feedData == nil {
            feedData = response
        } else {
            feedData?.hasMore = response.hasMore
            feedData?.errorMessage = response.errorMessage
            feedData?.state = response.state
            
            feedData?.publications += response.publications
        }

        callBack(State.ok)
    }
    
}
