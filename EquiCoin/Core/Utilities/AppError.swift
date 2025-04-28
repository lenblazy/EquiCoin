//
//  AppError.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

enum AppError: String, Error {
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from server. Please try again."
    case invalidRequestUrl  = "Invalid request URL. Please check and try again."
    case invalidData        = "The data received from server was invalid. Please try again."
    case unableToFavorite   = "We were unable to favorite"
    case unknownError       = "Something went wrong"
    case noCoinsFound       = "I am sorry, we could not find any coins."
    case alreadyFavorite    = "Coin already favorited"
}
