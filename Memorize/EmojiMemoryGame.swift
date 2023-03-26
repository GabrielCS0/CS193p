//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gabriel on 15/03/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷️"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
