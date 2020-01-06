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

protocol LeaguesDataRepositoryProtocol {
    func retrieveLeaguesBy(name: String,
                           success: @escaping ([Leagues.League]) -> Void,
                           failure: @escaping (LeaguesDataRepositoryError) -> Void)
    func saveLeagues(_ leagues: Leagues)
}

final class LeaguesDataRepository {
    
}

extension LeaguesDataRepository: LeaguesDataRepositoryProtocol {
    func retrieveLeaguesBy(name: String,
                           success: @escaping ([Leagues.League]) -> Void,
                           failure: @escaping (LeaguesDataRepositoryError) -> Void) {
        let filtered = LeaguesData.shared.leagues.leagues.filter {
            $0.name.lowercased().contains(name.lowercased())
        }
        
        if filtered.isEmpty {
            failure(.empty)
        } else {
            success(filtered)
        }
    }
    
    func saveLeagues(_ leagues: Leagues) {
        LeaguesData.shared.save(leagues)
    }
}
