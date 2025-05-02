//
//  String+Ext.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import Foundation

extension String {
    
    func formatPrice() -> String {
        guard let number = Double(self) else { return self }
        
        let formatter                   = NumberFormatter()
        formatter.numberStyle           = .currency
        formatter.currencySymbol        = "$ "
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 2
        
        guard let formatted = formatter.string(from: NSNumber(value: number)) else {
            return self
        }
        return formatted
    }
    
}
