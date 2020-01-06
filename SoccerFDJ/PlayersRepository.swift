//
//  PlayersRepository.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

enum PlayersRepositoryError: Error {
    case empty
    case error(Error)
}

protocol PlayersRepositoryProtocol {
    func retrievePlayers(in team: String,
                         success: @escaping (Players) -> Void,
                         failure: @escaping (PlayersRepositoryError) -> Void)
}

final class PlayersRepository {
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
}

extension PlayersRepository: PlayersRepositoryProtocol {
    func retrievePlayers(in team: String,
                         success: @escaping (Players) -> Void,
                         failure: @escaping (PlayersRepositoryError) -> Void) {
        
        self.requestManager.fetchPlayers(in: team).responseJSON { response in
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
                let players = try decoder.decode(Players.self, from: data)
                if players.isEmpty {
                    failure(.empty)
                } else {
                    success(players)
                }
            } catch {
                failure(.error(error))
            }
        }
    }
}
