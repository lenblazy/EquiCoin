//
//  UserDefaultsStorage.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 01/05/2025.
//

import Foundation

class UserDefaultsStorage: Storage {
    
    func save<T: Codable>(_ object: T, for key: String) async throws {
        do {
            if let _ = try await fetch(for: key) as T? {
                throw AppError.alreadyFavorite
            }
            
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(object)
            UserDefaults.standard.set(encoded, forKey: key)
        } catch {
            throw AppError.unableToFavorite
        }
    }
    
    
    func fetch<T: Codable>(for key: String) async throws -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    
    func delete(for key: String) async {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

enum StorageKeys {
    static let favorites = "Favorites"
}
