//
//  League.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

struct Leagues: Codable {
    let leagues: [League]
}

struct League: Codable {
    let idLeague: String
    let strLeague: String
    let strSport: String
    
    var teams: [Team] = []
    
    enum CodingKeys: String, CodingKey {
        case idLeague = "idLeague"
        case strLeague = "strLeague"
        case strSport = "strSport"
    }
}
