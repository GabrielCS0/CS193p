//
//  AddThemeView.swift
//  Memorize
//
//  Created by Gabriel on 31/07/23.
//

import Combine
import SwiftUI

struct AddThemeView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: HomeViewModel
//    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Name") {
                    TextField("Theme name", text: $viewModel.newThemeName)
                }

                Section("Emojis") {
                    EmojiOnlyTextField(text: $viewModel.newThemeEmojis, placeholder: "Theme emojis")
                        .onChange(of: viewModel.newThemeEmojis) { newEmojis in
                            viewModel.newThemeEmojis = newEmojis.onlyEmojis()
                        }

                    Picker("Pre made theme", selection: $viewModel.preMadeTheme) {
                        ForEach(viewModel.preMadeThemeNames, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Card") {
                    ColorPicker("Theme color", selection: $viewModel.newThemeColor, supportsOpacity: false)
                    
                    Picker("Pairs of cards to show", selection: $viewModel.numberOfPairsOfCardsInNewTheme) {
                        ForEach(1..<viewModel.newThemeEmojis.count + 1, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .disabled(viewModel.newThemeEmojis.isEmpty)
                }
            }
            .navigationTitle("New Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.addNewTheme()
                        if viewModel.showingErrorAlert == false { dismiss() }
                    }
                }
            }
            .alert("Complete all the fields correctly", isPresented: $viewModel.showingErrorAlert) {} message: {
                Text(viewModel.errorAlertMessage)
            }
        }
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

struct AddThemeView_Previews: PreviewProvider {
    static var previews: some View {
        AddThemeView(viewModel: HomeViewModel())
    }
}
