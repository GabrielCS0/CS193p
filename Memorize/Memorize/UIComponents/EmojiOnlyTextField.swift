//
//  EmojiOnlyTextField.swift
//  Memorize
//
//  Created by Gabriel on 31/07/23.
//

import SwiftUI

class UIEmojiOnlyTextField: UITextField {
    override var textInputContextIdentifier: String? { "" }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default
                return mode
            }
        }
        
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
}

struct EmojiOnlyTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiOnlyTextField {
        let emojiOnlyTextField = UIEmojiOnlyTextField()
        emojiOnlyTextField.placeholder = placeholder
        emojiOnlyTextField.text = text
        emojiOnlyTextField.delegate = context.coordinator
        return emojiOnlyTextField
    }
    
    func updateUIView(_ uiView: UIEmojiOnlyTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiOnlyTextField
        
        init(parent: EmojiOnlyTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}
