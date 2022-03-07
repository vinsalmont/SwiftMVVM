//
//  CardService.swift
//  swiftMVVM
//
//  Created by Vinicius Salmont on 06/03/22.
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

final class CardService {

    private enum ApiURL {
        case db
        case base

        var baseURL: String {
            switch self {
            case .db: return "https://db.ygoprodeck.com/api/v7"
            case .base: return "https://ygoprodeck.com"
            }
        }
    }

    private enum Endpoint {
        case cardList
        case imageArchetype
        case imageLevel
        case imageType
        case imageSpellType
        case imageMonster

        var path: String {
            switch self {
            case .cardList: return "/cardinfo.php"
            case .imageArchetype: return "/pics/icons/archetype.png"
            case .imageLevel: return "wp-content/uploads/2017/01/level.png"
            case .imageType: return ""
            case .imageSpellType: return ""
            case .imageMonster: return ""
            }
        }

        var url: String {
            switch self {
            case .cardList: return "\(ApiURL.db.baseURL)\(path)"
            default: return ":"
            }
        }

    }

    static func getAllCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: Endpoint.cardList.url) else {
                  completion(.failure(CustomError.noConnection))
                  return
              }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }

            do {
                let cards = try JSONDecoder().decode(CardResponse.self, from: data)
                completion(.success(cards.data))
            } catch let error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
            }

        }.resume()

    }
}
