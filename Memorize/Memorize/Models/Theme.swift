//
//  Theme.swift
//  Memorize
//
//  Created by Gabriel on 24/07/23.
//

import SwiftUI

struct Theme: Identifiable {
    let id = UUID()
    let name: String
    let emojis: [String] // Set
    let numberOfPairsOfCards: Int
    let color: Color
    
    static let example = Theme(
        name: "Faces",
        emojis: ["🫠", "🫣", "🤢", "🥱", "😵‍💫", "🤥", "🤫", "🫡", "🤑", "🤠", "😶‍🌫️", "🥶", "🤯", "🤧", "😮‍💨", "😢", "🫥", "🥸"],
        numberOfPairsOfCards: 17,
        color: .yellow
    )
}
