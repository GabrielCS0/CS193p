//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gabriel on 14/03/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGameViewModel
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(4)
                .foregroundColor(game.theme.color)
                .onTapGesture {
                    game.choose(card: card)
                }
        }
        .padding(.horizontal, 5)
        .padding(.vertical)
        .navigationTitle("Score: \(game.score)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                VStack(alignment: .leading) {
                    Button("Reset Game") {
                        game.resetGame()
                    }
                }
            }
        }
    }
}


struct CardView: View {
    let card: EmojiMemoryGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstant.shapeCornerRadius)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstant.shapeLineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5)
                        .opacity(0.6)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstant.fontScale)
    }
    
    private struct DrawingConstant {
        static let shapeCornerRadius: CGFloat = 10
        static let shapeLineWidth: CGFloat = 3
        static let fontScale = 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmojiMemoryGameView(game: EmojiMemoryGameViewModel(theme: Theme.example))
        }
    }
}
