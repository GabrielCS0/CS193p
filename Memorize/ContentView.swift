//
//  ContentView.swift
//  Memorize
//
//  Created by Gabriel on 14/03/23.
//

import SwiftUI

struct ContentView: View {
    var game: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(game.cards) { card in
                CardView(card: card).onTapGesture {
                    game.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: EmojiMemoryGame())
    }
}
