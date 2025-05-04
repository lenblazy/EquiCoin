//
//  SvgImage+Ext.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import SVGKit

extension SVGKImage {
    
    static let cache = NSCache<NSString, SVGKImage>()
    
    static func cacheImage(from endPoint: String) async -> SVGKImage? {
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
            
            guard let image = SVGKImage(data: data),
                  image.hasSize(),
                  image.size != .zero,
                  !image.size.width.isNaN,
                  !image.size.height.isNaN else {
                print("⚠️ Invalid SVG image from \(endPoint)")
                return nil
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            return image
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
}
