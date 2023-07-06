//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gabriel on 14/03/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    enum EmojisTheme {
        case faces, flags, animals
    }
    
    let faces = ["🫠", "🫣", "🤢", "🥱", "😵‍💫", "🤥", "🤫", "🫡", "🤑", "🤠", "😶‍🌫️", "🥶", "🤯", "🤧", "😮‍💨", "😢", "🫥", "🫨", "🥸"]
    let flags = ["🇧🇷", "🇦🇺", "🇯🇵", "🇰🇷", "🇨🇳", "🇦🇷", "🇷🇺", "🇺🇸", "🇵🇹", "🇲🇽", "🇨🇦", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇳🇬", "🇶🇦", "🇬🇷", "🇫🇮", "🇺🇾", "🇲🇨", "🇳🇱", "🇬🇪"]
    let animals = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐯", "🦁", "🐮", "🐷", "🐵", "🪿", "🐸", "🐥", "🐊", "🐙"]
    
    @State private var emojisCurrentlyShown: [String]
    private var numberOfCardsShown: Int {
        return Int.random(in: 4...emojisCurrentlyShown.count)
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(emojisCurrentlyShown[0..<numberOfCardsShown], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            HStack {
                Spacer()
                themeButton(.faces, SFSymbol: "face.smiling", describingText: "Faces")
                Spacer()
                themeButton(.flags, SFSymbol: "flag", describingText: "Flags")
                Spacer()
                themeButton(.animals, SFSymbol: "hare", describingText: "Animals")
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    func themeButton(_ theme: EmojisTheme, SFSymbol: String, describingText: String) -> some View {
        Button {
            changeEmojisTheme(theme)
        } label: {
            VStack(spacing: 5) {
                Image(systemName: SFSymbol).font(.largeTitle)
                Text(describingText).font(.callout)
            }
        }
    }
    
    func changeEmojisTheme(_ theme: EmojisTheme) {
        switch theme {
        case .faces:
            emojisCurrentlyShown = faces.shuffled()
        case .flags:
            emojisCurrentlyShown = flags.shuffled()
        case .animals:
            emojisCurrentlyShown = animals.shuffled()
        }
    }
    
    init() {
        self.emojisCurrentlyShown = self.faces.shuffled()
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
