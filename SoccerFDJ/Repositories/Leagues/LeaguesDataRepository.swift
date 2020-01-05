//
//  LeaguesDataRepository.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

enum LeaguesDataRepositoryError: Error {
    case empty
}

protocol LeaguesDataRepositoryItemProtocol {
    var leagueName: String { get }
}

protocol LeaguesDataRepositoryProtocol {
    func retrieveBy(leagues: String,
                    success: @escaping ([LeaguesDataRepositoryItemProtocol]) -> Void,
                    failure: @escaping (LeaguesDataRepositoryError) -> Void)
}

// FAIRE 2 REPO : 1 - retrive API : 2- SAVE / RETrieveBY

final class LeaguesDataRepository {
    //TO DO
    //Class pour l'appel reseau
    
//    var currentLeaguesResponse: [LeaguesResponseProtocol]
    
//    private init() {}
    
    
}

extension LeaguesDataRepository: LeaguesDataRepositoryProtocol {
    func retrieveBy(leagues: String,
                    success: @escaping ([LeaguesDataRepositoryItemProtocol]) -> Void,
                    failure: @escaping (LeaguesDataRepositoryError) -> Void) {
        // NE PAS OUBLIER SUPPRIMER ESPACE POUR %20
        
//        guard let currentLeaguesResponse  is empty else {
//            failure(.empty)
//        }
        
//        currentLeaguesResponse.contains else {
//            failure(.empty)
//        }
        
        /*¨
        let ligue1 = LeaguesRepositoryItem(leagueName: "ligue1")
        let ligue2 = LeaguesRepositoryItem(leagueName: "ligue2")
        let ligue3 = LeaguesRepositoryItem(leagueName: "Ligue3")
        ¨*/
//        success([ligue1, ligue2, ligue3])
        
    }
    
//    func save(request: [LeguesRequestProtocol]) {
//     currentLeaguesResponse = request
//    }
    
//    func retrieve(success: @escaping([LeaguesRepositoryItemProtocol]) -> Void,
//                  failure: @escaping(Error) -> Void) {
//        // Appel WS =>
//        
//        // convert data via decodable + retoune success ou failure.
//        // Ce n'est pas le repo qui décide de save mais le métier == PRESENTER
//    }
}

private struct LeaguesDataRepositoryItem: LeaguesDataRepositoryItemProtocol {
    var leagueName: String
}
