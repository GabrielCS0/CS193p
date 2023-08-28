//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Gabriel on 15/03/23.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    @Published private(set) var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { emojis[$0] }
    }
    
    var cards: [Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
    }
}
