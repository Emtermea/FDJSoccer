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

protocol LeaguesApiRepositoryProtocol {
    //    func retrieve(success: @escaping ([AllLeaguesRepositoryItemProtocol]) -> Void,
    //                  failure: @escaping (AllLeaguesRepositoryError) -> Void) {
        

    func retrieve(success: @escaping (Leagues) -> Void,
                  failure: @escaping (LeaguesApiRepositoryError) -> Void)
}

final class LeaguesApiRepository {
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
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
        // Ce n'est pas le repo qui décide de save mais le métier == PRESENTER
    }
}
