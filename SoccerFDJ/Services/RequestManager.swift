//
//  RequestManager.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation
import Alamofire

private let baseUrl: String = "https://www.thesportsdb.com/api/v1/json/1/"

protocol RequestManagerProtocol {
    func fetchLeagues() -> DataRequest
    func fetchTeams(in league: String) -> DataRequest
}

final class RequestManager {
    
}

extension RequestManager: RequestManagerProtocol {
    func fetchLeagues() -> DataRequest {
        let urlLeagues = URL(string: "\(baseUrl)all_leagues.php")!
        return AF.request(urlLeagues)
    }
    
    func fetchTeams(in league: String) -> DataRequest {
        let urlTeams = URL(string: "\(baseUrl)search_all_teams.php?l=\(league.replacingOccurrences(of: " ", with: "%20"))")!
        return AF.request(urlTeams)
    }
}
