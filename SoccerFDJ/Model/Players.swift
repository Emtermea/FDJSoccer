//
//  Players.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

struct Players: Codable {
    let players: [Player]
    
    var isEmpty: Bool {
        return self.players.isEmpty
    }
    enum CodingKeys: String, CodingKey {
        case players = "player"
    }
}

extension Players {
    struct Player: Codable {
        let id: String
        let name: String
        let position: String
        let price: String
        let profileUrl: String?
        let birthDate: String
        
        enum CodingKeys: String, CodingKey {
            case id = "idPlayer"
            case name = "strPlayer"
            case position = "strPosition"
            case price = "strSigning"
            case profileUrl = "strCutout"
            case birthDate = "dateBorn"
        }
    }
}

