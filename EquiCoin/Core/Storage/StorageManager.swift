//
//  StorageManager.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import Foundation

enum StorageActionType {
    case add, remove
}

protocol StorageManager {
    func updateWith(favorite: Coin, actionType: StorageActionType) async throws
    func retrieveFavorites() async throws -> [Coin]
}

struct DefaultsStorageManager: StorageManager {
    
    private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    func updateWith(favorite: Coin, actionType: StorageActionType) async throws {
        do {
            var favorites = try await retrieveFavorites()
            switch actionType {
            case .add:
                guard !favorites.contains(favorite) else {
                    throw AppError.alreadyFavorite
                }
                
                favorites.append(favorite)
            case .remove:
                favorites.removeAll { $0.id == favorite.id }
            }
            
            try await save(favorites: favorites)
        } catch {
            debugPrint(error)
            throw error
        }
        
    }
    
    func retrieveFavorites() async throws -> [Coin] {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let coins = try decoder.decode([Coin].self, from: favoritesData)
            return coins
        } catch {
            debugPrint(error)
            throw AppError.unableToFavorite
        }
    }
    
    private func save(favorites: [Coin]) async throws {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        } catch {
            debugPrint(error)
            throw AppError.unableToFavorite
        }
    }
    
}
