//
//  LeaguesApiRepository.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

enum LeaguesApiRepositoryError: Error {
    case empty
    case error(Error)
}

protocol LeaguesApiRepositoryItemProtocol {
    var leagueName: String { get }
}

protocol LeaguesApiRepositoryProtocol {
    //    func retrieve(success: @escaping ([AllLeaguesRepositoryItemProtocol]) -> Void,
    //                  failure: @escaping (AllLeaguesRepositoryError) -> Void) {
        

    func retrieve(success: @escaping (Leagues) -> Void,
                  failure: @escaping (LeaguesApiRepositoryError) -> Void)
}

// FAIRE 2 REPO : 1 - retrive API : 2- SAVE / RETrieveBY

final class LeaguesApiRepository
{
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    //TO DO
    //Class pour l'appel reseau
    
//    var currentLeaguesResponse: [LeaguesResponseProtocol]
    
//    private init() {}
    
    
    
}

extension LeaguesApiRepository: LeaguesApiRepositoryProtocol {
    func retrieve(success: @escaping (Leagues) -> Void,
                  failure: @escaping (LeaguesApiRepositoryError) -> Void) {
        
        self.requestManager.fetchLeagues().responseJSON { response in
            guard let data = response.data else {
                if let error = response.error {
                    failure(.error(error))
                } else {
                    failure(.empty)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let leagues = try decoder.decode(Leagues.self, from: data)
                if leagues.isEmpty {
                    failure(.empty)
                } else {
                    success(leagues)
                }
            } catch {
                failure(.error(error))
            }
            
        }
        // Appel WS =>
        
        // convert data via decodable + retoune success ou failure.
        // Ce n'est pas le repo qui décide de save mais le métier == PRESENTER
    }
}

//private struct AllLeaguesRepositoryItem: AllLeaguesRepositoryItemProtocol {
//    var leagueName: String
//}
