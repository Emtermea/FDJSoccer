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
}

struct Team: Codable {

    let leagueId: String
    let teamId: String
    let leagueName: String
    let teamName: String
    let teamBadge: String
    
    enum CodingKeys: String, CodingKey {
        case leagueId = "idLeague"
        case teamId = "idTeam"
        case leagueName = "strLeague"
        case teamName = "strTeam"
        case teamBadge = "strTeamBadge"
    }
}
