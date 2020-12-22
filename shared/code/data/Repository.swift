//
//  Repository.swift
//  techday
//
//  Created by Vanderlei Martinelli on 21/12/20.
//

import Foundation

enum CustomError: Error {
    case jsonNotFound
}

final class Repository {
    
    func fetchMatches(completion: @escaping(Result<[Match], Error>) -> Void) {
        // Dispatched on a secondary thread to simulate a network request behaviour
        DispatchQueue.global().async {
            do {
                guard let path = Bundle.main.path(forResource: "matches", ofType: "json") else {
                    throw CustomError.jsonNotFound
                }

                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let response = try JSONDecoder().decode(Matches.self, from: data)

                completion(.success(response.matches))

            } catch {
                completion(.failure(error))
            }
        }
    }
}
