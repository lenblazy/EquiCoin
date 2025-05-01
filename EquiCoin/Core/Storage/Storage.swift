//
//  AppStorage.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 01/05/2025.
//

import Foundation

protocol Storage {
    func save<T: Codable>(_ object: T, for key: String) async throws
    func fetch<T: Codable>(for key: String) async throws -> T?
    func delete(for key: String) async
}
