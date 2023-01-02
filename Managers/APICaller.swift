//
//  APICaller.swift
//  USParksExplorer
//
//  Created by Devin Ercolano on 12/31/22.
//

import Foundation

struct Constants {
    static let API_KEY = "FXIwuub9PaRyk0BG7tpqaekCNn2bTiHPPcx9iJMC"
    static let baseURL = "https://developer.nps.gov/api/v1"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getParks(completion: @escaping (Result<[Park], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/parks?&api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(Parks.self, from: data)
                completion(.success(results.data))
        
//                print("Results: \(results.data)")
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
