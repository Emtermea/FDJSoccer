//
//  Leagues.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

struct Leagues: Codable {
    let leagues: [League]
    
    var isEmpty: Bool {
        return self.leagues.isEmpty
    }
}

extension Leagues {
    struct League: Codable {
        let id: String
        let name: String
        let sport: String
        
        var teams: [Teams.Team] = []
        
        enum CodingKeys: String, CodingKey {
            case id = "idLeague"
            case name = "strLeague"
            case sport = "strSport"
        }
    }
}
