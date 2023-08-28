//
//  HomeView.swift
//  Memorize
//
//  Created by Gabriel on 31/07/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.themes) { theme in
                    NavigationLink {
                        EmojiMemoryGameView(game: EmojiMemoryGameViewModel(theme: theme))
                    } label: {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.title3)
                            
                            HStack {
                                Text(theme.emojis[...4].joined())
                                    .font(.system(size: 20))
                                if theme.emojis.count > 5 {
                                    Text("+\(theme.emojis.count - 5)")
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteThemes)
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingAddThemeScreen = true
                    } label: {
                        Label("Add Theme", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddThemeScreen) {
                AddThemeView(viewModel: viewModel)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
