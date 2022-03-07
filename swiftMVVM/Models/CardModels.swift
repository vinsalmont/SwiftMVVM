//
//  CardModels.swift
//  swiftMVVM
//
//  Created by Vinicius Salmont on 06/03/22.
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

struct CardResponse: Codable {
    let data: [Card]
}

struct Card: Codable {
    let id: Int
    let name: String
    let type: String
    let desc: String
    let atk: Int?
    let def: Int?
    let level: Int?
    let race: String
    let attribute: String?
    let archetype: String?
    let cardSets: [CardSet]?
    let cardImages: [CardImage]
    let cardPrices: [CardPrices]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case desc = "desc"
        case atk = "atk"
        case def = "def"
        case level = "level"
        case race = "race"
        case attribute = "attribute"
        case archetype = "archetype"
        case cardSets = "card_sets"
        case cardImages = "card_images"
        case cardPrices = "card_prices"
    }

}

struct CardSet: Codable {
    let setName: String
    let setCode: String
    let setRarity: String
    let setPrice: String

    enum CodingKeys: String, CodingKey {
        case setName = "set_name"
        case setCode = "set_code"
        case setRarity = "set_rarity"
        case setPrice = "set_price"
    }
}

struct CardPrices: Codable {
    let market: String
    let player: String
    let ebay: String
    let amazon: String

    enum CodingKeys: String, CodingKey {
        case market = "cardmarket_price"
        case player = "tcgplayer_price"
        case ebay = "ebay_price"
        case amazon = "amazon_price"
    }
}

struct CardImage: Codable {
    let id: Int
    let imageURL: String
    let imageURLSmall: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "image_url"
        case imageURLSmall = "image_url_small"
    }
}
