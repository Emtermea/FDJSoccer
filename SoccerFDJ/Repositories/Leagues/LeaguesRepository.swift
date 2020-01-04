//
//  LeaguesRepository.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

enum LeaguesRepositoryError: Error {
    case empty
}

protocol LeaguesRepositoryItemProtocol {
    var leagueName: String { get }
}

protocol LeaguesRepositoryProtocol {
    func retrieveBy(leagues: String,
                    success: @escaping ([LeaguesRepositoryItemProtocol]) -> Void,
                    failure: @escaping (LeaguesRepositoryError) -> Void)
}

// FAIRE 2 REPO : 1 - retrive API : 2- SAVE / RETrieveBY

final class LeaguesRepository {
    //TO DO
    //Class pour l'appel reseau
    
//    var currentLeaguesResponse: [LeaguesResponseProtocol]
    
//    private init() {}
    
    
}

extension LeaguesRepository: LeaguesRepositoryProtocol {
    func retrieveBy(leagues: String,
                    success: @escaping ([LeaguesRepositoryItemProtocol]) -> Void,
                    failure: @escaping (LeaguesRepositoryError) -> Void) {
        // NE PAS OUBLIER SUPPRIMER ESPACE POUR %20
        
//        guard let currentLeaguesResponse  is empty else {
//            failure(.empty)
//        }
        
//        currentLeaguesResponse.contains else {
//            failure(.empty)
//        }
        
        let ligue1 = LeaguesRepositoryItem(leagueName: "ligue1")
        let ligue2 = LeaguesRepositoryItem(leagueName: "ligue2")
        let ligue3 = LeaguesRepositoryItem(leagueName: "Ligue3")
        
        success([ligue1, ligue2, ligue3])
        
    }
    
//    func save(request: [LeguesRequestProtocol]) {
//     currentLeaguesResponse = request
//    }
    
    func retrieve(success: @escaping([LeaguesRepositoryItemProtocol]) -> Void,
                  failure: @escaping(Error) -> Void) {
        // Appel WS =>
        
        // convert data via decodable + retoune success ou failure.
        // Ce n'est pas le repo qui décide de save mais le métier == PRESENTER
    }
}

private struct LeaguesRepositoryItem: LeaguesRepositoryItemProtocol {
    var leagueName: String
}
