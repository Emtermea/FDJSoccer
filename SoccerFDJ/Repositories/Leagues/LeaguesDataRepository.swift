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

//protocol LeaguesDataRepositoryItemProtocol {
//    var leagueName: String { get }
//}

protocol LeaguesDataRepositoryProtocol {
    func retrieveBy(leagues: String,
                    success: @escaping ([Leagues.League]) -> Void,
                    failure: @escaping (LeaguesDataRepositoryError) -> Void)
    func retrieveLeaguesBy(name: String,
                           success: @escaping ([Leagues.League]) -> Void,
                           failure: @escaping (LeaguesDataRepositoryError) -> Void)
    func saveLeagues(_ leagues: Leagues)
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
                    success: @escaping ([Leagues.League]) -> Void,
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
    
    func retrieveLeaguesBy(name: String,
                           success: @escaping ([Leagues.League]) -> Void,
                           failure: @escaping (LeaguesDataRepositoryError) -> Void) {
        let filtered = LeaguesData.shared.leagues.leagues.filter {
//            $0.name.caseInsensitiveCompare(name) == .orderedSame
            $0.name.lowercased().contains(name.lowercased())
        }
        
        if filtered.isEmpty {
            failure(.empty)
        } else {
            success(filtered)
        }
    }
    
//    func save(request: [LeguesRequestProtocol]) {
//     currentLeaguesResponse = request
//    }
    

    func saveLeagues(_ leagues: Leagues) {
        LeaguesData.shared.save(leagues)
    }
}

//private struct LeaguesDataRepositoryItem: LeaguesDataRepositoryItemProtocol {
//    var leagueName: String
//}
