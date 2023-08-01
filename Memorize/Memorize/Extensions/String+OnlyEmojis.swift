//
//  String+OnlyEmojis.swift
//  Memorize
//
//  Created by Gabriel on 31/07/23.
//

import Foundation

extension String {
    func onlyEmojis() -> String {
        return self.filter { $0.isEmoji }
    }
}

extension Character {
    var isEmoji: Bool {
        if let scalar = unicodeScalars.first, scalar.properties.isEmoji {
            return (scalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}
