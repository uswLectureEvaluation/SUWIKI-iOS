//
//  DepartmentCategoryReactor.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/31.
//

import Foundation
import ReactorKit

final class DepartmentCategoryReactor: Reactor {
    
    struct State {
        var test: String
    }
    
    enum Action {
        case temp
    }
    
    var initialState: State
    
    init() {
        self.initialState = State(test: "Hi")
    }
    
}
