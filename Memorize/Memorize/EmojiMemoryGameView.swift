//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gabriel on 14/03/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    let emojis = ["🫠", "🫣", "🤢", "🥱", "😵‍💫", "🤥", "🤫", "🫡", "🤑", "🤠", "😶‍🌫️", "🥶", "🤯", "🤧", "😮‍💨", "😢", "🫥", "😼", "🫨", "🥸"]
    @State private var showingEmojiAmount = 20
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<showingEmojiAmount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            HStack {
                Button {
                    if showingEmojiAmount > 1 {
                        showingEmojiAmount -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle")
                }
                
                Spacer()
                
                Button {
                    if showingEmojiAmount < emojis.count {
                        showingEmojiAmount += 1
                    }
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture { isFaceUp.toggle() }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
            .preferredColorScheme(.dark)
    }
}
