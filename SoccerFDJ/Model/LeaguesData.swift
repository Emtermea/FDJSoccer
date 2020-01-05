//
//  LeaguesData.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

final class LeaguesData {
    
    //MARK: Properties
    static let shared = LeaguesData()
    var leagues: Leagues = Leagues(leagues: [])
    
    private init() {}
}

extension LeaguesData {
    func save(_ leagues: Leagues) {
        self.leagues = leagues
    }
}


