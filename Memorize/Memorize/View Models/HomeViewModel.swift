//
//  HomeViewModel.swift
//  Memorize
//
//  Created by Gabriel on 01/08/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var themes: [Theme] = []
    @Published var newThemeName = ""
    @Published var numberOfPairsOfCardsInNewTheme = 0
    @Published var newThemeColor = Color.purple
    @Published var newThemeEmojis = "" {
        didSet {
            numberOfPairsOfCardsInNewTheme = newThemeEmojis.count
        }
    }
    
    @Published var showingAddThemeScreen = false
    @Published var showingErrorAlert = false
    @Published var errorAlertMessage = ""
    
    @Published var preMadeTheme = "None" {
        willSet(theme) {
            choosePreMadeTheme(theme)
        }
    }
    let preMadeThemeNames = ["None", "Faces", "Flags", "Animals", "Foods", "Sports", "Vehicles"]
    
    func deleteThemes(at offsets: IndexSet) {
        themes.remove(atOffsets: offsets)
    }
    
    func addNewTheme() {
        let trimmedName = newThemeName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedName.count > 2 else {
            errorAlertMessage = "Enter a suitable name for your theme!"
            showingErrorAlert = true
            return
        }
        
        let emojisArray = makeUniqueEmojisArray(from: newThemeEmojis)
        
        guard emojisArray.count >= 5 else {
            errorAlertMessage = "Add more unique emojis to your theme!"
            showingErrorAlert = true
            return
        }
        
        let newTheme = Theme(name: trimmedName, emojis: emojisArray, numberOfPairsOfCards: numberOfPairsOfCardsInNewTheme, color: newThemeColor)
        
        themes.append(newTheme)
        
        // StateObject !=
        newThemeName = ""
        newThemeEmojis = ""
        newThemeColor = .purple
    }
    
    private func makeUniqueEmojisArray(from emojis: String) -> [String] {
        var uniqueEmojis: [String] = []
        for character in emojis {
            if !uniqueEmojis.contains(String(character)) {
                uniqueEmojis.append(String(character))
            }
        }
        
        return uniqueEmojis
    }
    
    private func choosePreMadeTheme(_ theme: String) {
        func updateNewThemeValues(name: String, emojis: String, color: Color) {
            newThemeName = name
            newThemeEmojis = emojis
            newThemeColor = color
        }

        switch theme {
        case "Faces":
            updateNewThemeValues(name: "Faces", emojis: "🫠🫣🤢🥱😵‍💫🤥🤫🫡🤑🤠😶‍🌫️🥶🤯🤧😮‍💨😢🫥🥸", color: .yellow)
        case "Flags":
            updateNewThemeValues(name: "Flags", emojis: "🇧🇷🇦🇺🇯🇵🇰🇷🇨🇳🇦🇷🇷🇺🇺🇸🇵🇹🇲🇽🇨🇦🏴󠁧󠁢󠁥󠁮󠁧󠁿🇳🇬🇶🇦🇬🇷🇫🇮🇺🇾🇲🇨🇳🇱🇬🇪", color: .green)
        case "Animals":
            updateNewThemeValues(name: "Animals", emojis: "🐶🐱🐭🐰🦊🐻🐼🐻‍❄️🐯🦁🐮🐷🐵🐸🐥🐊🐙", color: .brown)
        case "Foods":
            updateNewThemeValues(name: "Foods", emojis: "🍏🍎🍊🍋🍌🍉🍇🍓🍒🍍🥥🥝🥑🥕🍞🥖🍗🥪🍕🍪🍫🍭🍦", color: .red)
        case "Sports":
            updateNewThemeValues(name: "Sports", emojis: "⚽️🏀⚾️🎾🏐🏉🥏🏓🏒🏏🥍⛳️🥊🥋🛹🏹🛼⛷️", color: .blue)
        case "Vehicles":
            updateNewThemeValues(name: "Vehicles", emojis: "🚗🚕🚙🚌🏎️🚓🚑🚒🚐🛻🚚🚛🚜🏍️🛵🚲🛺🚖", color: .gray)
        default:
            updateNewThemeValues(name: "", emojis: "", color: .purple)
        }
    }
}
