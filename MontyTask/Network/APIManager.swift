//
//  APIClient.swift
//  MontyTask
//
//  Created by Hussein kandil on 26/10/2023.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    let baseUrl = "https://api.spacexdata.com"
    let launchesEndpoint = "/v4/launches"
    let rocketsEndpoint = "/v4/rockets"
    
    func getLaunches(completion: @escaping (Result<[LaunchesResponse], AFError>) -> Void) {
        
        let stringUrl = baseUrl + launchesEndpoint
        
        AF.request(stringUrl, method: .get)
            .validate()
            .responseDecodable(of: [LaunchesResponse].self) { response in
                completion(response.result)
            }
    }
    
    func getRocket(id: String, completion: @escaping (Result<[Rocket], AFError>) -> Void) {
        let apiUrl = baseUrl + rocketsEndpoint
        
        let parameters: [String: Any] = ["id": id]
        
        AF.request(apiUrl, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: [Rocket].self) { response in
                completion(response.result)
            }
    }
}
