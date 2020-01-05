//
//  Team.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

struct Teams: Codable {
    let teams: [Team]
    
    var isEmpty: Bool {
        return self.teams.isEmpty
    }
}

extension Teams {
    struct Team: Codable {
        
        let id: String
        let name: String
        let badge: String
        let leagueName: String
        let leagueId: String
        
        enum CodingKeys: String, CodingKey {
            
            case id = "idTeam"
            case name = "strTeam"
            case badge = "strTeamBadge"
            case leagueId = "idLeague"
            case leagueName = "strLeague"
        }
    }
}
