//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gabriel on 14/03/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    let columns = [
        GridItem(.adaptive(minimum: 65)) 
    ]
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text(game.theme.name)
                        .font(.title)
                        .bold()
                    
                    Text("Your score: \(game.score)")
                        .font(.subheadline)
                }

                Spacer()
            }
            .padding(.bottom)
            
            LazyVGrid(columns: columns) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .foregroundColor(game.theme.color)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card: card)
                        }
                }
            }
        }
        .padding()
        .toolbar {
            Button("Reset Game") {
                game.resetGame()
            }
        }
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmojiMemoryGameView(game: EmojiMemoryGame(theme: Theme.example))
        }
    }
}
