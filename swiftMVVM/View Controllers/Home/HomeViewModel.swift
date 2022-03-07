//
//  HomeViewModel.swift
//  swiftMVVM
//
//  Created by Vinicius Salmont on 06/03/22.
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

enum Types: Int, CaseIterable {
    case all
    case monsters
    case spell
    case trap

    var name: String {
        switch self {
        case .all: return "All"
        case .monsters: return "Monsters"
        case .spell: return "Spell"
        case .trap: return "Trap"
        }
    }
    
}

final class HomeViewModel {
    weak var delegate: RequestDelegate?
    private var cards: [Card] = []
    private var filteredCards: [Card] = []
    private var selectedType: Types = .all {
        didSet {
            self.filterData()
        }
    }
}

// MARK: - DataSource
extension HomeViewModel {
    var numberOfItems: Int {
        filteredCards.count
    }

    func getCard(for indexPath: IndexPath) -> Card {
        filteredCards[indexPath.row]
    }

    func filterByType(type: Types) {
        self.selectedType = type
    }

    func selectedTypeName() -> String {
        self.selectedType.name
    }
}

// MARK: - Service
extension HomeViewModel {
    func loadData() {
        CardService.getAllCards { result in
            switch result {
            case let .success(cards):
                self.cards = cards
                self.filteredCards = cards
                self.delegate?.didFinish(with: .success)
            case let .failure(error):
                self.cards = []
                self.filteredCards = []
                self.delegate?.didFinish(with: .failed(error))
            }
        }
    }
}

// MARK: - Filter Data
private extension HomeViewModel {
    func filterData() {
        guard selectedType != .all else {
            self.filteredCards = cards
            self.delegate?.didFinish(with: .success)
            return
        }

        guard selectedType != .monsters else {
            self.filteredCards = self.cards.filter { !$0.type.lowercased().contains(Types.spell.name.lowercased()) && !$0.type.lowercased().contains(Types.trap.name.lowercased()) }
            self.delegate?.didFinish(with: .success)
            return
        }

        self.filteredCards = self.cards.filter { $0.type.lowercased().contains(self.selectedType.name.lowercased()) }
        self.delegate?.didFinish(with: .success)
    }
}
