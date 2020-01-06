//
//  TeamsRepository.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

enum TeamsRepositoryError: Error {
    case empty
    case error(Error)
}

protocol TeamsRepositoryProtocol {
    func retrieveTeams(in league: String,
                       success: @escaping (Teams) -> Void,
                       failure: @escaping (TeamsRepositoryError) -> Void)
}

final class TeamsRepository {
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension TeamsRepository: TeamsRepositoryProtocol {
    func retrieveTeams(in league: String,
                       success: @escaping (Teams) -> Void,
                       failure: @escaping (TeamsRepositoryError) -> Void) {
        
        self.requestManager.fetchTeams(in: league).responseJSON { response in
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
                let teams = try decoder.decode(Teams.self, from: data)
                if teams.isEmpty {
                    failure(.empty)
                } else {
                    success(teams)
                }
            } catch {
                failure(.error(error))
            }
        }
    }
}
