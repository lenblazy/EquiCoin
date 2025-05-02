//
//  UIImageView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

extension UIImage {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func cacheImage(from endPoint: String) async -> UIImage? {
        do {
            let cacheKey = NSString(string: endPoint)
            
            if let image = cache.object(forKey: cacheKey) {
                return image
            }
            
            guard let url = URL(string: endPoint) else { return nil }
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            
            return image
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
}
